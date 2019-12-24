TARGET = lu
OBJS = lu.o
CFLAGS = -O2 -w
LDFLAGS = -lpthread -lm -msse2

$(TARGET): $(OBJS)
	gcc $(OBJS) $(CFLAGS) -o $(TARGET) $(LDFLAGS)
