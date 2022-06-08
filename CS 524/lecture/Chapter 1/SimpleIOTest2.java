
import java.util.Scanner;

public class SimpleIOTest2 {
	public static void main(String[] args) {
		Scanner in = new Scanner(System.in);
		
		System.out.print("Enter a string, an integer, and a double, separated by a space(s): ");
		String s = in.next();
		int a = in.nextInt();
		double x = in.nextDouble();
		
		System.out.println("s = " + s);
		System.out.println("a = " + a);
		System.out.println("x = " + x);
		in.close();
	}
}
