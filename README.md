Примеры bazel rules
===================

Пример A
--------

Мы ходим запустить маленький shell скрипт и не хотим писать свой rule
В этом нам поможет https://docs.bazel.build/versions/master/be/general.html#genrule

# генерирует файл bazel-bin/a_1.txt
```
➜ bazel build //:a_1
INFO: Invocation ID: 623e7039-c11f-4e22-abda-2fa084e1b518
INFO: Analysed target //:a_1 (2 packages loaded, 18 targets configured).
INFO: Found 1 target...
Target //:a_1 up-to-date:
  bazel-bin/1.txt
INFO: Elapsed time: 0,316s, Critical Path: 0,05s
INFO: 1 process: 1 darwin-sandbox.
INFO: Build completed successfully, 2 total actions
➜ cat bazel-bin/1.txt
example a
```

# читает bazel-bin/a_1.txt и два раза его записывает в bazel-bin/a_2.txt
```
➜ bazel build //:a_2
INFO: Invocation ID: 66f0e303-45b3-447f-a20b-588eda8a8fcc
INFO: Analysed target //:a_2 (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //:a_2 up-to-date:
  bazel-bin/a_2.txt
INFO: Elapsed time: 0,117s, Critical Path: 0,00s
INFO: 0 processes.
INFO: Build completed successfully, 1 total action
➜ cat bazel-bin/a_2.txt
example a
example a
```

Пример Б
--------

Теперь сделаем некоторую тулзятину //:my_super_tool, которая первым аргументом принимает строку, а вторым - файл, куда нужно её записать

Это реализуется при помощи rule `b_executable`

Дальше сделаем rule, который настраивается строкой "content" и вызывает некоторую внешнюю тулзу два раза, и результат склекает в файл

```
➜ bazel build //:b
INFO: Invocation ID: c357dc35-3d17-41d3-8a1a-3706bdee72c3
INFO: Analysed target //:b (1 packages loaded, 2 targets configured).
INFO: Found 1 target...
INFO: From SkylarkAction b:
some content
some content
Target //:b up-to-date:
  bazel-bin/b
INFO: Elapsed time: 0,190s, Critical Path: 0,07s
INFO: 1 process: 1 darwin-sandbox.
INFO: Build completed successfully, 2 total actions
➜ cat bazel-bin/b
some content
some content
```