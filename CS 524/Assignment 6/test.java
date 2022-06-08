import java.io.*;
import java.util.*;

public class test {

        public static void main(String[] args) throws Exception {

                try {
                        ArrayList<Node> adjList = new ArrayList<>();
                        Scanner scanner = new Scanner(new File("follows_input.txt"));
                        while (scanner.hasNextLine()) {
                                String ar[] = scanner.nextLine().split(",");
                                String src = ar[0];
                                src = src.trim();

                                Node node = new Node(src);
                                for (int i = 1; i < ar.length; i++) {
                                        String des = ar[i];
                                        des = des.trim();
                                        node.follows.add(des);
                                }
                                adjList.add(node);
                        }

                        // method for displaying the follows graph
                        displayFollowsGraph(adjList);
                        System.out.println();
            //allFollows calling on "D"
                        allFollows("D", adjList);

                } catch (Exception e) {
                        e.printStackTrace();
                }

        }

        // method which prints all the people X directly and indirectly follows
        static void allFollows(String X, ArrayList<Node> adjList) {
                PriorityQueue<String> pQueue = new PriorityQueue<>();
                Set<String> processedPersons = new TreeSet<>();
                Set<String> indirectFollows = new TreeSet<>();
                ArrayList<String> directFollows = new ArrayList<String>();
                for (Node n : adjList) {
                        if (n.name.equals(X)) {
                                directFollows = n.follows;
                                for (String following : n.follows) {
                                        pQueue.add(following);
                                }
                                break;
                        }
                }
                System.out.println(X + " directly follows " + directFollows);
        
                while (!pQueue.isEmpty()) {
                        String currentPerson = pQueue.remove();
                        if (processedPersons.add(currentPerson)) {

                                for (Node n : adjList) {
                                        if (n.name.equals(currentPerson)) {
                                                for (String following : n.follows) {
                                                        pQueue.add(following);
                                                        if (!directFollows.contains(following))
                                                                indirectFollows.add(following);
                                                }
                                                break;
                                        }

                                }

                        }
                }

                System.out.println(X + " indirectly follows " + indirectFollows);

        }

        static void displayFollowsGraph(ArrayList<Node> adjList) {
                for (Node n : adjList) {
                        System.out.println(n.name + " " + n.follows);
                }
        }

        static class Node {
                String name;
                ArrayList<String> follows = new ArrayList<>();

                public Node(String name) {
                        this.name = name;
                }
        }

}
