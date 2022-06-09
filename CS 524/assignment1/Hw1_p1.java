
// import java.util.Arrays;

public class Hw1_p1 {
	
	public static void find(int[] a, int x) {
		int len = a.length;//get length of array
		int decide = 0;
		// for loop find where the x located
		for(int i = 0; i < len; i++){
			if(a[i] == x){
				decide = 1;
				System.out.println(x + " is in a["+i+"]");
			}
		}
		if(decide == 0){
			System.out.println(x + " does not exist");
		}
		decide = 0;
	}
	
	public static boolean isPrefix(String s1, String s2) {
		int len1 = s1.length(), len2 = s2.length();//get length of string s1 and s2
		//use if statement when len1 larger than len2, s1 can't be prefix of s2
		if(len1 > len2)
			return false;
		for(int i = 0; i < len1; i++)//for loop when charater which locate same position doesn't equal, return "is not a prefix"
			if(s1.charAt(i) != s2.charAt(i))
				return false;
		return true;

	}
		
	
	
	public static void main(String[] args) {
		
		int[] a = {5, 3, 5, 6, 1, 2, 12, 5, 6, 1};
		
		find(a, 5);
		find(a, 10);
		System.out.println();
		String s1 = "abc";
		String s2 = "abcde";
		String s3 = "abdef";
		
		if (isPrefix(s1,s2)) {
			System.out.println(s1 + " is a prefix of " + s2);
		}
		else {
			System.out.println(s1 + " is not a prefix of " + s2);
		}
		
		if (isPrefix(s1,s3)) {
			System.out.println(s1 + " is a prefix of " + s3);
		}
		else {
			System.out.println(s1 + " is not a prefix of " + s3);
		}
	}
}