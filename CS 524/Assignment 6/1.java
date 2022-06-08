import java.util.ArrayList;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.io.PrintWriter;

class ProcessScheduling1 {

     // We create a Process class that represents our processes
    protected static class Process {
        // Each process has a process id, priority, duration, and arrival time
        private int processId;
        private int priority;
        private int duration;
        private int arrivalTime;

        // We set the default values when creating an empty Process
        public Process() {
            processId = 0;
            priority = 0;
            duration = 0;
            arrivalTime = 0;
        };

        // We set the values when creating a Process with given parameters
        public Process(int processId, int priority, int duration, int arrivalTime) {
            this.processId = processId;
            this.priority = priority;
            this.duration = duration;
            this.arrivalTime = arrivalTime;
        };

        // We can get each of the process values
        public int getProcessId() {return processId;};
        public int getPriority() {return priority;};
        public int getDuration() {return duration;};
        public int getArrivalTime() {return arrivalTime;};

        // We can set each of the process values
        public void setProcessId(int processId) {this.processId = processId;};
        public void setPriority(int priority) {this.priority = priority;};
        public void setDuration(int duration) {this.duration = duration;};
        public void setArrivalTime(int arrivalTime) {this.arrivalTime = arrivalTime;};

        // We can return the process in a string representation
        public String toString() {
            String s = new String();
            s += "Id = " + processId + ", ";
            s += "priority = " + priority + ", ";
            s += "duration = " + duration + ", ";
            s += "arrival time = " + arrivalTime;
            return s;
        };
    };

    public static void main(String[] args) throws FileNotFoundException {
        // We use a scanner to read from a given input file
        Scanner s = new Scanner(new File("process_scheduling_in.txt"));
        // We use printwriter to write our output to a file
        PrintWriter writer = new PrintWriter("process_scheduling_out.txt");

        // We use an ArrayList as the data structure that will hold our input processes
        ArrayList<Process> D = new ArrayList<>();

        // We read our input file, create a process for each line read, and add each
        //   process to our ArrayList
        while (s.hasNext()) {
            String line = s.nextLine();
            String[] lineContents = line.split(" ");
            Process p1 = new Process(Integer.parseInt(lineContents[0]), Integer.parseInt(lineContents[1]), Integer.parseInt(lineContents[2]), Integer.parseInt(lineContents[3]));
            D.add(p1);
        };

        // We close our scanner
        s.close();

        // We note how many processes are in our original input file
        int numberOfProcesses = D.size();

        // We write each of our input processes onto the output file
        for (int i=0; i<D.size(); i++) {
            writer.println(D.get(i));
        };
        writer.println();

        // We create variables that keep track of:
        // The "current time" in our simulation
        int currentTime = 0;
        // Whether we are currently running a process or not
        boolean running = false;
        // We also create our empty priority queue
        HeapPriorityQueue<Integer, Process> Q = new HeapPriorityQueue<>();

        Process p = new Process();
        // A Process runningP that is the currently running process
        Process runningP = new Process();
        int waitTime = 0;
        // A double that will calculate our average wait time
        double averageWaitTime = 0;
        // An int that keeps track of the currently running process's end time
        int endTime = 0;

        // This loop runs once for every time unit until D (our ArrayList) is empty
        while (!D.isEmpty()) {
            int earliest = D.get(0).getArrivalTime();
            int earliestIndex = 0;
            for (int i=0; i<D.size(); i++) {
                int temp = D.get(i).getArrivalTime();
                if (temp < earliest) {
                    earliest = temp;
                    earliestIndex = i;
                };
            };
            p = D.get(earliestIndex);
            // If the arrival time of p <= our current time
            if (p.getArrivalTime() <= currentTime) {
                // We remove process p from D and insert it into Q (our priority queue)
                Q.insert(p.getPriority(), p);
                D.remove(earliestIndex);
            };
            // If Q is not empty AND there is no currently running process (running is false)
            if (!Q.isEmpty() && !running) {
                // We remove a process with a smallest priority from Q
                runningP = Q.removeMin().getValue();
                // We determine some values that we will write to our file
                waitTime = currentTime - runningP.getArrivalTime();
                averageWaitTime += waitTime;
                endTime = currentTime + runningP.getDuration();
                // We write to our file
                writer.println("Process removed from queue is: id = " + runningP.getProcessId() + ", at time " + currentTime + ", wait time = " + waitTime + ", Total wait time = " + averageWaitTime);
                writer.println("Process id = " + runningP.getProcessId() + "\n\tPriority = " + runningP.getPriority() + "\n\tArrival = " + runningP.getArrivalTime() + "\n\tDuration = " + runningP.getDuration());
                // We note that we are currently running a process (running is true)
                running = true;
            };
            // We increment the current time by 1
            currentTime += 1;
            // If there is a process running AND it just ended
            if (running && endTime == currentTime) {
                // We write to our file that our process has ended
                writer.println("Process " + runningP.getProcessId() + " finished at time " + endTime + "\n");
                // We note that our process is no longer running (running is false)
                running = false;
            };
        };
        writer.println("\nD becomes empty at time " + (currentTime-1) +"\n");
        // While there is a process waiting in Q (Q is not empty)
        while (!Q.isEmpty()) {
            // If there is no currently running process (running is false)
            if (!running) {
                // We remove a process with a smallest priority from Q
                runningP = Q.removeMin().getValue();
                // We determine some values that we will write to our file
                waitTime = currentTime - runningP.getArrivalTime();
                averageWaitTime += waitTime;
                endTime = currentTime + runningP.getDuration();
                // We write to our file
                writer.println("Process removed from queue is: id = " + runningP.getProcessId() + ", at time " + currentTime + ", wait time = " + waitTime + ", Total wait time = " + averageWaitTime);
                writer.println("Process id = " + runningP.getProcessId() + "\n\tPriority = " + runningP.getPriority() + "\n\tArrival = " + runningP.getArrivalTime() + "\n\tDuration = " + runningP.getDuration());
                // We note that we are currently running a process (running is true)
                running = true;
            };
            // We increment the current time by 1
            currentTime += 1;
            // If there is a process running AND it just ended
            if (running && endTime == currentTime) {
                // We write to our file that our process has ended
                writer.println("Process " + runningP.getProcessId() + " finished at time " + endTime + "\n");
                // We note that our process is no longer running (running is false)
                running = false;
            };
        };
        writer.println("Process " + runningP.getProcessId() + " finished at time " + endTime + "\n");
        // We write to our file the total wait time of all processes
        writer.println("Total wait time = " + averageWaitTime);
        // We calculate our average wait time for all processes
        averageWaitTime /= numberOfProcesses;
        // We write to our file the average wait time for all processes
        writer.print("Average wait time = " + averageWaitTime);
        // We close our PrintWriter
        writer.close();
    };
};