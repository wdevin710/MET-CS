import java.io.*;
import java.util.*;
import java.io.PrintWriter;

public class ProcessScheduling {
    //write process class
    protected static class Process{
        // create int processid, priority, arrival time, duration
        int processid;
        int priority;
        int arrivaltime;
        int duration;
        public Process() {
            processid = 0;
            priority = 0;
            duration = 0;
            arrivaltime = 0;
        };
        // give value to those int
        public Process(int processid, int priority, int duration,int arrivaltime){
            this.processid = processid;
            this.priority = priority;
            this.arrivaltime = arrivaltime;
            this.duration = duration;
        }
        public String toString() {
            String s = new String();
            s += "Id = " + processid + ", ";
            s += "priority = " + priority + ", ";
            s += "duration = " + duration + ", ";
            s += "arrival time = " + arrivaltime;
            return s;
            };    
        public int getProcessid() {return processid;};
        public int getPriority() {return priority;};
        public int getDuration() {return duration;};
        public int getArrivaltime() {return arrivaltime;};
    }
    public static void main(String[]args) throws FileNotFoundException{
         // read input file
        Scanner scanner = new Scanner(new File("process_scheduling_input.txt"));
        PrintWriter w = new PrintWriter("process_scheduling_output.txt");
        //create new arraylist to stored input process
        ArrayList<Process> A = new ArrayList<>();
        //give value to our arraylist
        while (scanner.hasNextLine()){
            String ar[] = scanner.nextLine().split(",");
            Process B = new Process(Integer.parseInt(ar[0]), Integer.parseInt(ar[1]), Integer.parseInt(ar[2]), Integer.parseInt(ar[3]));
            A.add(B);
        }
        scanner.close();

        int N = A.size();

        for (int i=0; i<A.size(); i++) {
            w.println(A.get(i));
        };
        w.println();
        // create currentime, waittime, avetime, endtime, and running process or not boolean
        int currenttime = 0;
        int waittime = 0;
        float avetime = 0;
        int endtime = 0;
        boolean run = false;
        HeapPriorityQueue<Integer, Process> Q = new HeapPriorityQueue<>();
        Process p = new Process();
        Process running = new Process();

        // recurit when input file is empty
        while(!A.isEmpty()){
            int first = A.get(0).getArrivaltime();
            int firstindex = 0;
            for(int i =0; i< A.size();i++){
                int temp = A.get(i).getArrivaltime();
                if(temp < first){
                    first = temp;
                    firstindex = i;
                }
            }
            p = A.get(firstindex);
            //when arrival time <= currentime, remove the least priority process
            if(p.getArrivaltime()<= currenttime){
                Q.insert(p.getArrivaltime(),p);
                A.remove(firstindex);
            }
            if (!Q.isEmpty() && !run){
                running = Q.removeMin().getValue();
                waittime = currenttime - running.getArrivaltime();
                avetime += waittime;
                endtime = currenttime + running.getDuration();
                w.println("Process removed from queue is: id = " + running.getProcessid() + ", at time " + currenttime + ", wait time = " + waittime + ", Total wait time = " + avetime);
                w.println("Process id = " + running.getProcessid() + "\n\tPriority = " + running.getPriority() + "\n\tArrival = " + running.getArrivaltime() + "\n\tDuration = " + running.getDuration());
                run = true;
            }
            currenttime += 1;
            if (run && endtime == currenttime){
                w.println("Process " + running.getProcessid() + " finished at time " + endtime + "\n");
                run = false;
            }
        }
        w.println("\nD becomes empty at time " + (currenttime-1) +"\n");
        while (!Q.isEmpty()){
            if (!run){
                running = Q.removeMin().getValue();
                waittime = currenttime - running.getArrivaltime();
                avetime += waittime;
                endtime = currenttime + running.getDuration();
                w.println("Process removed from queue is: id = " + running.getProcessid() + ", at time " + currenttime + ", wait time = " + waittime + ", Total wait time = " + avetime);
                w.println("Process id = " + running.getProcessid() + "\n\tPriority = " + running.getPriority() + "\n\tArrival = " + running.getArrivaltime() + "\n\tDuration = " + running.getDuration());
                run = true;
            }
            currenttime += 1;
            if (run && endtime == currenttime){
                w.println("Process " + running.getProcessid() + " finished at time " + endtime + "\n");
                run = false;
            }
        }
        w.println("Process " + running.getProcessid() + " finished at time " + endtime + "\n");
        w.println("Total wait time = " + avetime);
        avetime /= N;
        w.print("Average wait time = " + avetime);
        w.close();
        


        

    }
    
}
