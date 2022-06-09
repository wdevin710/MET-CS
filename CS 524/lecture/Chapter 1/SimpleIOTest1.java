
import java.util.Scanner;

public class SimpleIOTest1 {
	public static void main(String[] args) {
		Scanner in = new Scanner(System.in);
		System.out.print("Enter a string: ");
		String s = in.next();
		System.out.print("Enter an integer: ");
		int a = in.nextInt();
		System.out.print("Enter a double: ");
		double x = in.nextDouble();
		
		System.out.println("s = " + s);
		System.out.println("a = " + a);
		System.out.println("x = " + x);
		in.close();
	}
}