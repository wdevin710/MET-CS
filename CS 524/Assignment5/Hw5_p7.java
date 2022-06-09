import java.util.Arrays;
import java.util.Random;

class Campare{
    public static void InsertionSort(int arr[]){
        int n = arr.length;
        for(int k = 1; k <n; k++ ){  // begin with second int
            int curr = arr[k];       // time to insert curr=arr[k]
            int j = k;              // find correct index j for cur
            while(j > 0  && arr[j-1] > curr) { // thus, data[j-1] must go after curr
                arr[j] = arr[j-1];              // slide data[j-1] rightward
                j--;                            // and consider previous j for curr
            }                               
            arr[j]= curr;                       // this is the proper place for curr
        }
    }

    public static void Merge(int[]S1,int[]S2,int[]a,int left, int right){
        int i =0, j =0, k =0;
        while(i<left &&  j <right){
            if(S1[i] <= S2[j])
                a[k++] = S1[i++];
            else
                a[k++] = S2[j++];
        while(i <left){
            a[k++] = S1[i++];
        }
        while(j < right){
            a[k++] = S2[j++];
        }
        }
    }
    public static void MergeSort(int[]a, int n){
        if(n<2) return;     // array is trivially sorted

        int mid = n/2;
        int [] S1 = Arrays.copyOfRange(a, 0, mid);    // copy of first half
        int [] S2 = Arrays.copyOfRange(a, mid, n);    // copy of second half
        // conquer (with recursion)
        MergeSort(S1, mid);   // sort copy of first half
        MergeSort(S2, n-mid);    // sort copy of second half
        // merge results
        Merge(S1,S2,a,mid,n-mid);     // merge sorted halves back into original
    }   
    static int partition(int arr[], int low, int high) { 
        int pivot = arr[high];  
        int i = (low-1); // index of smaller element 
        for (int j=low; j<high; j++) { 
            if (arr[j] < pivot){ 
                i++; 
                int temp = arr[i]; 
                arr[i] = arr[j]; 
                arr[j] = temp; 
            } 
        } 

        // swap arr[i+1] and arr[high] (or pivot) 
        int temp = arr[i+1]; 
        arr[i+1] = arr[high]; 
        arr[high] = temp; 
        return i+1; 
    } 

    static void quickSort(int arr[], int low, int high) { 
        if (low < high) { 
            int pi = partition(arr, low, high); 
            // Recursively sort elements before partition and after partition 
            quickSort(arr, low, pi-1); 
            quickSort(arr, pi+1, high); 
        } 
    } 


    public static void heapify(int arr[], int n, int i){
        int k = i;
        int l = 2*i+1;
        int r = 2*i+2;
        if(l < n && arr[l]>arr[k])
            k = l;
        if(r < n && arr[r]>arr[k])
            k = r;
        if( k != i){
            int p = arr[i];
            arr[i] = arr[k];
            arr[k] = p;
            heapify(arr, n, k);
        }


    }
    public static void HeapSort(int arr[]){
        int n = arr.length;
        // Build heap (rearrange array)
        for (int i = n/2 - 1; i>=0;i--){
            heapify(arr,n,i);
        }
        for (int i = n-1; i>0;i-- ){
            int temp = arr[0];
            arr[0] = arr[i];
            arr[i] = temp;
            heapify(arr,i,0);

        }

    }
    public static void main(String args[]){
        int c[],b[],d[];
        long startTime;
        long endTime;
        long elapsedTime;
        long elapsedtimeForInsertion[]= new long[10];
        long elapsedtimeForMerge[]= new long[10];
        long elapsedtimeForQuick[]= new long[10];
        long elapsedtimeForHeap[]= new long[10];
        Random r = new Random();
        int y = 0;
        int n = 10000;
        while(n <= 100000){
            int arr [] = new int[n];
            for(int i=0;i<n;i++){
                arr[i] = r.nextInt(1000000)+1;
            }
            b = arr.clone();
            c = arr.clone();
            d = arr.clone();
            // find the elapsed time for InsertionSort sort
            startTime = System.currentTimeMillis();
            InsertionSort(arr);
            endTime = System.currentTimeMillis();
            elapsedTime = endTime - startTime;
            elapsedtimeForInsertion [y]= elapsedTime;

            // find the elapsed time for MergeSort sort
            startTime = System.currentTimeMillis();
            MergeSort(c, c.length);;;
            endTime = System.currentTimeMillis();
            elapsedTime = endTime - startTime;
            elapsedtimeForMerge[y]= elapsedTime;

            // find the elapsed time for QuickSort sort
            startTime = System.currentTimeMillis();
            quickSort(b, 0, b.length-1);
            endTime = System.currentTimeMillis();
            elapsedTime = endTime - startTime;
            elapsedtimeForQuick[y]= elapsedTime;

            // find the elapsed time for HeapSort sort
            startTime = System.currentTimeMillis();
            HeapSort(d);
            endTime = System.currentTimeMillis();
            elapsedTime = endTime - startTime;
            elapsedtimeForHeap[y]= elapsedTime;

            y++;
            n = n+ 10000;
        }
        System.out.println("----------------------------------------------------------------------------------------------");
        System.out.println("\nn\t\t10000 \t20000 \t30000 \t40000 \t50000 \t60000 \t70000 \t80000 \t90000 \t100000");
        System.out.println("----------------------------------------------------------------------------------------------");
        
        System.out.print("insertion\t");
        for(long i: elapsedtimeForInsertion){
            System.out.print(i+"\t");
        }
        System.out.println();
        System.out.print("merge\t\t");
        for(long i :elapsedtimeForMerge){
            System.out.print(i+"\t");
        }
        System.out.println();
        System.out.print("quick\t\t");
        for(long i : elapsedtimeForQuick){
            System.out.print(i+"\t");
        }
        System.out.println();
        System.out.print("heap\t\t");
        for(long i : elapsedtimeForHeap){
            System.out.print(i+"\t");
        }
        System.out.println();
        System.out.println("----------------------------------------------------------------------------------------------");
    }   
}