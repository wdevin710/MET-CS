import java.io.IOException;
import java.io.File;
import java.util.Scanner;

class Car {
 
	String make;
	int year;
	int price;

	public Car(String m, int y, int p) {
		make = m;
		year = y;
		price = p;
	}
	public String getMake() { return make; }   
	public int getYear() { return year; }
	public int getPrice() { return price; }

	public String toString() {
		String c =
				 "\tMake = " + make +
				 "\tYear = " + year +
				 "\tPrice = " + price;
		return c;
	}
 
  }
public class Hw1_p2 {

	public static void findByMake(Car[] cars, String make) {
		for(int i=0; i < cars.length; i++){
			if(cars[i].make.equals(make))
				System.out.println(cars[i]);
		}
		// implement this method
	}
	
	public static void newerThan(Car[] cars, int year) {
		for(int i = 0; i <cars.length; i++){
			if(cars[i].year > year)
				System.out.println(cars[i]);
		}
		// implement this method
	}
	
	public static void main(String[] args) throws IOException {
		Car[] cars = new Car[9];//create an empty array
		File file = new File("/Users/haowu/Desktop/Boston University Graduate Study/CS 524/assignment1/car_input.txt");//path and file read
		Scanner myFile = new Scanner(file);//scaaner and read file
		int q = 0;
		//for loop run each line and convert string to integer
		while(myFile.hasNextLine()){
			String line = myFile.nextLine();
			String[] arr = line.split(", ");//split each by parameter","
			String y = arr[0];
			int x = Integer.parseInt(arr[2]);//Price is arr 2
			int z = Integer.parseInt(arr[1]);//Year is arr 1
			cars[q] = new Car(y,x,z);
			q++;
		}
		myFile.close();
		System.out.println("\nAll cars:");
		for (int i=0; i < cars.length; i++) {
			System.out.println(cars[i]);
		}
		
		String make = "Honda";
		int year = 2017;
		
		System.out.println("\nAll cars made by " + make);
		findByMake(cars, make);
		System.out.println("\nAll cars made after " + year);
		newerThan(cars, year);
		
	}
	
}