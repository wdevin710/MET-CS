public class TestCar {

	public static void main(String[] args) {
		Car c1 = new Car("ABCD", "GM", 2015, 15000);
		Car c2 = new Car("WXYZ", "Ford", 2020, 20000);
		
		System.out.println("Car c1 is: \n" + c1);
		System.out.println("Car c2 is: \n" + c2);
		
		Car c3 = new Car();
		c3.setVIN("B123");
		c3.setMake("Honda");
		c3.setYear(2010);
		c3.setPrice(18000);
		
		System.out.println();
		System.out.println("VIN of car c3 is: " + c3.getVIN());
		System.out.println("Make of car c3 is: " + c3.getMake());

		System.out.println();
		System.out.println("Number of cars, with static method, is: " + Car.getNumberOfCars());
		
		// array of cars
		Car c4, c5, c6;
		Car carArray[] = new Car[3];
		
		c4 = new Car();
		c4.setVIN("1234");
		c4.setMake("Hyundai");
		c4.setYear(2003);
		c4.setPrice(5000);
		carArray[0] = c4;
		
		c5 = new Car();
		c5.setVIN("2345");
		c5.setMake("Kia");
		c5.setYear(2008);
		c5.setPrice(8000);
		carArray[1] = c5;
		
		c6 = new Car("3456", "Chevy", 2012, 12000);
		carArray[2] = c6;
		
		System.out.println("\n\nCar array  ");
		for (int i=0; i<carArray.length; i++) {
			System.out.println(carArray[i]);
		}
		
		System.out.println();
		System.out.println("Number of cars, with static method, is: " + Car.getNumberOfCars());
		
	}
	
}