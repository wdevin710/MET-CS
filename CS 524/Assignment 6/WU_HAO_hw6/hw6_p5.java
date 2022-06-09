import java.io.*;
import java.util.*;

public class hw6_p5{

    static class node{
        String x;
        ArrayList<String>array = new ArrayList<>();

        public node(String x){
            this.x = x;
        }
    }
    
    public static void allFollows(String a, ArrayList<node>adj){
        PriorityQueue<String> temp = new PriorityQueue<>();
        ArrayList<String> direct = new ArrayList<String>();
        ArrayList<String> indirect = new ArrayList<String>();
        Set<String>people = new TreeSet<>();
        String name;
        for(node b:adj){
            if(b.x.equals(a)){
                direct = b.array;
                for(String follow: b.array){
                    temp.add(follow);
                }

                

            break;
            }
        }
        System.out.println(a + "directly follows" + direct);
        while (!temp.isEmpty()) {
            name = temp.remove();
            if(people.add(name)){
                for(node b:adj){
                    if(b.x.equals(name)){
                        for(String follow: b.array){
                            temp.add(follow);
                            if(!direct.contains(follow))
                                indirect.add(follow);
                        }
                    }
                }
            }
            

        }
        System.out.println(a + " indirectly follows " + indirect);



    }

    public static void main(String[] args) throws Exception{
        ArrayList<node> adjList = new ArrayList<>();
        Scanner scanner = new Scanner(new File("follows_input.txt"));
        while (scanner.hasNextLine()){
            String ar[] = scanner.nextLine().split(",");
            String s = ar[0];
            s = s.trim();

            node b = new node(s);
            for(int i = 1; i<ar.length; i++){
                String k = ar[i];
                k = k.trim();
                b.array.add(k);
            }
            adjList.add(b);
        }
        allFollows("A", adjList);
    }
        
    
}