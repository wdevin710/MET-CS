
public class PrimitiveReference {

	public static void main(String[] args) {
		int a, b;
		Car c1, c2; 
		
		a = 10;
		b = a;
		
		System.out.println("a = " + a + ", b = " + b);
		
		a = 20;
		System.out.println("After updating a:");
		System.out.println("a = " + a + ", b = " + b);
		
		System.out.println();
		
		
		
		String vin = "ABCD";
		String make = "GM";
		int year = 2010;
		int price = 10000;
		c1 = new Car(vin, make, year, price);
		c2 = c1;
		
		System.out.println("Car c1 is: \n" + c1);
		System.out.println("Car c2 is: \n" + c2);
		
		
		c1.setPrice(12000);
		
		System.out.println("After updating c1:");
		System.out.println("Car c1 is: \n" + c1);
		System.out.println("Car c2 is: \n" + c2);
		
	}

}