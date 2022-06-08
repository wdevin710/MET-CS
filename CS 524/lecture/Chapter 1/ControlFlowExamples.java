package MyPrograms;

import java.util.Scanner;

public class ControlFlowExamples {

	public static void main(String[] args) {
		
		Scanner in = new Scanner(System.in);
		System.out.println("Enter an integer: ");
		int a = in.nextInt();
		
		if (a > 0) {
			System.out.println("It is a positive number");
		}
		else if (a < 0) {
			System.out.println("It is a negative number");
		}
		else {
			System.out.println("It is zero");
		}
		
		
		// from Oracle Java tutorial
		
		in = new Scanner(System.in);
		System.out.println("Enter a month, as an integer: ");
		int month = in.nextInt();
		
		String monthString;
        switch (month) {
            case 1:  monthString = "January";
                     break;
            case 2:  monthString = "February";
                     break;
            case 3:  monthString = "March";
                     break;
            case 4:  monthString = "April";
                     break;
            case 5:  monthString = "May";
                     break;
            case 6:  monthString = "June";
                     break;
            case 7:  monthString = "July";
                     break;
            case 8:  monthString = "August";
                     break;
            case 9:  monthString = "September";
                     break;
            case 10: monthString = "October";
                     break;
            case 11: monthString = "November";
                     break;
            case 12: monthString = "December";
                     break;
            default: monthString = "Invalid month";
                     break;
        }
        System.out.println(month + " is " + monthString);
		
		
		// sum = 1 + 2 + . . . + 10
		
		int sum = 0;
		int i;
		
		for (i=0; i<=10; i++) {
			sum += i;
		}
		
		System.out.println("For loop: sum = " + sum);
		
		i=0;
		sum = 0;
		while (i <= 10) {
			sum += i;
			i++;
		}
		System.out.println("While loop: sum = " + sum);
		
		i = 0;
		sum = 0;
		do {
			sum += i;
			i++;
		} while (i <= 10);
		System.out.println("Do-while loop: sum = " + sum);
		
	}

}