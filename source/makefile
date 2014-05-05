all: filter filterSpeedUp filterScaleUp filterOP
filter:filter.o
	g++ filter.o -o filter -fopenmp -O3
filter.o: filter.c
	g++ filter.c -c -fopenmp 
filterSpeedUp:filterSpeedUp.o
	g++ filterSpeedUp.o -o filterSpeedUp -fopenmp -O3
filterSpeedUp.o: filterSpeedUp.c
	g++ filterSpeedUp.c -c -fopenmp -O3

filterScaleUp:filterScaleUp.o
	g++ filterScaleUp.o -o filterScaleUp -fopenmp
filterScaleUp.o: filterScaleUp.c
	g++ filterScaleUp.c -c -fopenmp
filterOP: filterOP.o
	g++ filterOP.o -o filterOP -fopenmp -O3 -w
filterOP.o: filterOP.c
	g++ filterOP.c -c -fopenmp -O3 -w
clean:
	rm -rf *o
