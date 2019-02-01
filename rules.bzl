def _impl_b_executable(ctx):
    result = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.write(result,
"""#!/bin/bash
echo $1 > $2
""", is_executable=True)
    return [DefaultInfo(executable=result)]


b_executable = rule(
    implementation = _impl_b_executable,
    executable = True
)

def _impl_b(ctx):
    result = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.run_shell(
        inputs = [ctx.executable.some_my_tool],
        outputs = [result],
        command = """#!/bin/bash
set -euo pipefail
a=$(mktemp)
b=$(mktemp)
{some_my_tool} "{content}" $a
{some_my_tool} "{content}" $b
cat $a >> {result}
cat $b >> {result}
""".format(
    some_my_tool=ctx.executable.some_my_tool.path,
    content = ctx.attr.content,
    result=result.path)
    )
    return [DefaultInfo(files=depset([result]))]


b = rule(
    implementation = _impl_b,
    attrs = {
        "content": attr.string(),
        "some_my_tool": attr.label(cfg = "host", executable=True)
    }
)
