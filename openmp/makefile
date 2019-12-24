TARGET = lu
OBJS = lu.o
CFLAGS = -O2 -w
LDFLAGS = -fopenmp -lm -msse2

$(TARGET): $(OBJS)
	gcc $(OBJS) $(CFLAGS) -o $(TARGET) $(LDFLAGS)
