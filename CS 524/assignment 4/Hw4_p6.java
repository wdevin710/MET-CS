import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Random;

class TimeSearch{
    public static void main(String args[]){
        HashMap<Integer,String>myMape = new HashMap<>();
        ArrayList<Integer> myArrayList = new ArrayList<>();
        LinkedList<Integer> myLinkedList = new LinkedList<>();
        long startTime,endTime,elapsedTime;

        int key[] = new int[1000000];
        Random r = new Random(1000000);
        for(int i = 0; i < key.length; i++){
            key[i] = r.nextInt(1000000)+1;
        }
        
        System.out.println("Number of keys =" + key.length);
        //Start 2 row
        startTime = System.currentTimeMillis();
        for(int i = 0; i < key.length; i++){
            myMape.put(key[i],"0");
        }
        endTime = System.currentTimeMillis();
        elapsedTime = endTime - startTime; 
        System.out.println("HashMap average total insert time = " + elapsedTime);

        //start 3 row
        startTime = System.currentTimeMillis();
        for(int i = 0; i < key.length; i++){
            myArrayList.add(key[i]);
        }
        endTime = System.currentTimeMillis();
        elapsedTime = endTime - startTime; 
        System.out.println("ArrayList average total insert time = " + elapsedTime);

        //start 4 row
        startTime = System.currentTimeMillis();
        for(int i = 0; i < key.length; i++){
            myArrayList.add(key[i]);
        }
        endTime = System.currentTimeMillis();
        elapsedTime = endTime - startTime; 
        System.out.println("LinkedList average total insert time = " + elapsedTime);

        r.setSeed(2000000);
        for(int i = 0; i < 1000000; i++){
            key[i] = r.nextInt(2000000)+1;
        }

        //start 5 row
        startTime = System.currentTimeMillis();
        for(int i = 0; i < key.length; i++){
            myMape.containsKey(key[i]);
        }
        endTime = System.currentTimeMillis();
        elapsedTime = endTime - startTime; 
        System.out.println("HashMap average total search time = " + elapsedTime);

        //start 6 row
        startTime = System.currentTimeMillis();
        for(int i = 0; i < key.length; i++){
            myArrayList.contains(key[i]);
        }
        endTime = System.currentTimeMillis();
        elapsedTime = endTime - startTime; 
        System.out.println("ArrayList average total search time = " + elapsedTime);

        //start 7 row
        startTime = System.currentTimeMillis();
        for(int i = 0; i < key.length; i++){
            myLinkedList.contains(key[i]);
        }
        endTime = System.currentTimeMillis();
        elapsedTime = endTime - startTime; 
        System.out.println("LinkedList average total search time = " + elapsedTime);









    }
}