# Perfilamento do LU (Splash2) <!-- no super computador -->

<!-- ## Configurando o ambiente parsec

Na pasta raiz do projeto parsec, para habilitar o comando parsecmgmt no ambiente do sistema deve ser executado o comando

```sh
$ source env.sh
```

Na pasta `config` no arquivo **gcc.bldconf** deve alterar as variáveis para:

export CFLAGS=" -pg -g -funroll-loops -fprefetch-loop-arrays ${PORTABILITY_FLAGS}"
export CXXFLAGS="-pg -g -funroll-loops -fprefetch-loop-arrays -fpermissive -fno-exceptions ${PORTABILITY_FLAGS}"

Na pasta `ext/splash2/kernels/lu_cb/src/` no arquivo **makefile**, deve alterar a variável para:

CFLAGS = -pg -w

## Construindo e executando o projeto

Após alteração caso já tenha feito o build antes disso:

```sh
$ parsecmgmt -a uninstall -p splash2.lu_cb
$ parsecmgmt -a uninstall -p splash2x.lu_cb
```

Caso não tenha feito a build ainda:

```sh
$ parsecmgmt -a build -p splash2.lu_cb
$ parsecmgmt -a build -p splash2x.lu_cb
```

Depois executar normalmente:

```sh
$ parsecmgmt -a run -p splash2x.lu_cb -i native
```

O arquivo **gmon.out** será gerado dentro da pasta `ext/splash2x/kernels/lu_cb/run` dentro do projeto.

## Preparando a execução do profiling

Na pasta `ext/splash2/kernels/lu_cb/run` foi criado um novo arquivo chamado **gmon.out**.

Mova esta arquivo para a pasta `ext/splash2x/kernels/lu_cb/inst/amd64-linux.gcc/bin`, onde haverá um arquivo executável **lu_cb**.

## Perfilamento com Gprof

```sh
$ gprof ./lu_cb gmon.out > report.txt
```

## Gprof2dot

```sh
$ gprof ./lu_cb | ./gprof2dot.py | dot -Tpng -o result.png
```

## Executar no supercomputador

Cria um arquivo `run` com:

```
#!/bin/bash
#SBATCH --time=0-0:30
time ./amd64-linux.gcc/lu.o -p1 -n8096 -b32
```

E executa:

```sh
$ sbatch run
```

-->

# Perfilar na máquina local

## Usando makefile

Nas pastas `./pthread` e `./openmp` tem um arquivo `makefile`.

```sh
$ make
```

## Compilando com gcc

Você pode compilar e executar o perfilamento na sua máquina local e ter o resultado no `report.txt`. Para tal, execute:

- Compilação com pthread:

```sh
$ gcc -pthread -g -o lu_pt lu_pt.c
```

- Compilação com OpenMP

```sh
$ gcc -fopen -g -o lu_mp lu_mp.c
```

- Execução com entrada "native" (10-25min):

```sh
$ time ./lu -p1 -n8192 -b16 -t
```

- Perfilamento:

```sh
$ gprof ./lu gmon.out > report.txt
```

- Gprof2dot:

```sh
$ chmod +x ./gprof2dot.py
$ gprof ./lu | ./gprof2dot.py | dot -Tpng -o result.png
```

## Executando a aplicação

- Execução com entrada "native" (10-25min):

```sh
$ time ./lu -p1 -n8192 -b16 -t
```

# Auto vetorização

Para habilitar a auto vetorização do algoritmo e salvar o _output_ em um arquivo _vectorization.txt_, compile o código com a seguinte instrução:

Com `funsafe-math-optimizations`:

```sh
$ gcc -pthread -g -o lu_vect_math.o lu.c -O3 -ftree-vectorize -funsafe-math-optimizations -msse2 -ftree-vectorizer-verbose=6 2> vect_math.txt -lm
```

Sem `funsafe-math-optimizations`:

```sh
$ gcc -pthread -g -o lu_vect.o lu.c -O3 -ftree-vectorize -msse2 -ftree-vectorizer-verbose=6 2> vect.txt -lm
```
