//fcfs
#include <stdio.h>
int main()
{
    int n;
    printf("Enter no of process : ");
    scanf("%d", &n);

    int bt[n], wt[n], tat[n], totalTAT = 0, totalWT = 0;

    for (int i = 0; i < n; i++)
    {
        printf("Enter process %d : ", i + 1);
        scanf("%d", &bt[i]);
    }
    wt[0] = 0;
    for (int i = 1; i < n; i++)
    {
        wt[i] = wt[i - 1] + bt[i - 1];
    }
    for (int i = 0; i < n; i++)
    {
        tat[i] = wt[i] + bt[i];
        totalTAT = totalTAT + tat[i];
        totalWT = totalWT + wt[i];
    }
    printf("Processes    Burst Time    Waiting Time    Turnaround Time\n");
    for (int i = 0; i < n; i++)
    {
        printf(" %d\t\t%d\t\t%d\t\t%d\n", i + 1, bt[i], wt[i], tat[i]);
    }

    printf("AVGTAT : %f\n", (float)totalTAT / n);
    printf("AVGWT : %f", (float)totalWT / n);
}

//sjf

#include <stdio.h>
int main()
{
    int n;
    printf("Enter no of process : ");
    scanf("%d", &n);
    int bt[n], pid[n], wt[n], tat[n], totalTAT = 0, totalWT = 0;

    for (int i = 0; i < n; i++)
    {
        printf("Enter process id : ");
        scanf("%d", &pid[i]);
        printf("Enter process bt : ");
        scanf("%d", &bt[i]);
    }
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = 0; j < n - 1; j++)
        {
            if (bt[j] > bt[j + 1])
            {
                // Swap burst time
                int temp = bt[j];
                bt[j] = bt[j + 1];
                bt[j + 1] = temp;
                // Swap process id
                temp = pid[j];
                pid[j] = pid[j + 1];
                pid[j + 1] = temp;
            }
        }
    }

    wt[0] = 0;
    for (int i = 1; i < n; i++)
    {
        wt[i] = wt[i - 1] + bt[i - 1];
    }
    for (int i = 0; i < n; i++)
    {
        tat[i] = wt[i] + bt[i];
        totalTAT = totalTAT + tat[i];
        totalWT = totalWT + wt[i];
    }
    printf("Processes    Burst Time    Waiting Time    Turnaround Time\n");
    for (int i = 0; i < n; i++)
    {
        printf(" %d\t\t%d\t\t%d\t\t%d\n", pid[i], bt[i], wt[i], tat[i]);
    }

    printf("AVGTAT : %f\n", (float)totalTAT / n);
    printf("AVGWT : %f", (float)totalWT / n);
}

//rr
#include <stdio.h>
#include <conio.h>

void main()
{
    // initlialize the variable name
    int i, NOP, sum = 0, count = 0, y, quant, wt = 0, tat = 0, at[10], bt[10], temp[10];
    float avg_wt, avg_tat;
    printf(" Total number of process in the system: ");
    scanf("%d", &NOP);
    y = NOP; // Assign the number of process to variable y

    // Use for loop to enter the details of the process like Arrival time and the Burst Time
    for (i = 0; i < NOP; i++)
    {
        printf("\n Enter the Arrival and Burst time of the Process[%d]\n", i + 1);
        printf(" Arrival time is: \t"); // Accept arrival time
        scanf("%d", &at[i]);
        printf(" \nBurst time is: \t"); // Accept the Burst time
        scanf("%d", &bt[i]);
        temp[i] = bt[i]; // store the burst time in temp array
    }
    // Accept the Time qunat
    printf("Enter the Time Quantum for the process: \t");
    scanf("%d", &quant);
    // Display the process No, burst time, Turn Around Time and the waiting time
    printf("\n Process No \t\t Burst Time \t\t TAT \t\t Waiting Time ");

    for (sum = 0, i = 0; y != 0;     ) 
    {
        if (temp[i] <= quant && temp[i] > 0) // define the conditions
        {
            sum = sum + temp[i];
            temp[i] = 0;
            count = 1;
        }
        else if (temp[i] > 0)
        {
            temp[i] = temp[i] - quant;
            sum = sum + quant;
        }

        if (temp[i] == 0 && count == 1)
        {
            y--; // decrement the process no.
            printf("\nProcess No[%d] \t\t %d\t\t\t\t %d\t\t\t %d", i + 1, bt[i], sum - at[i], sum - at[i] - bt[i]);
            wt = wt + sum - at[i] - bt[i];
            tat = tat + sum - at[i];
            count = 0;
        }

        if (i == NOP - 1)
        {
            i = 0;
        }
        else if (at[i + 1] <= sum)
        {
            i++;
        }
        else
        {
            i = 0;
        }
    }
    // represents the average waiting time and Turn Around time
    avg_wt = wt * 1.0 / NOP;
    avg_tat = tat * 1.0 / NOP;
    printf("\n Average Turn Around Time: \t%f", avg_wt);
    printf("\n Average Waiting Time: \t%f", avg_tat);
}

//pre
#include <stdio.h>

int main() {
    int n;
    printf("Enter number of processes: ");
    scanf("%d", &n);

    int id[n], bt[n], priority[n], wt[n], tat[n];
    int totalWT = 0, totalTAT = 0;

    for (int i = 0; i < n; i++) {
        id[i] = i + 1;
        printf("Enter burst time and priority for process %d: ", i + 1);
        scanf("%d %d", &bt[i], &priority[i]);
    }

    // Sorting processes by priority (lower number means higher priority)
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (priority[i] > priority[j]) {
                // Swapping burst time
                int temp = bt[i];
                bt[i] = bt[j];
                bt[j] = temp;

                // Swapping priority
                temp = priority[i];
                priority[i] = priority[j];
                priority[j] = temp;

                // Swapping process ID
                temp = id[i];
                id[i] = id[j];
                id[j] = temp;
            }
        }
    }

    // Calculate waiting times
    wt[0] = 0;
    for (int i = 1; i < n; i++) {
        wt[i] = wt[i - 1] + bt[i - 1];
    }

    // Calculate turnaround times and total times
    for (int i = 0; i < n; i++) {
        tat[i] = wt[i] + bt[i];
        totalWT += wt[i];
        totalTAT += tat[i];
    }

    // Display results
    printf("Processes    Burst Time    Waiting Time    Turnaround Time    Priority\n");
    for (int i = 0; i < n; i++) {
        printf(" %d\t\t%d\t\t%d\t\t%d\t\t%d\n", id[i], bt[i], wt[i], tat[i], priority[i]);
    }

    // Calculate and display average times
    printf("Average Waiting Time: %.2f\n", (float)totalWT / n);
    printf("Average Turnaround Time: %.2f\n", (float)totalTAT / n);

    return 0;
}

//file

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main()
{
    int fd;
    char buffer[80];
    char msg[15] = "hello world";

    fd = open("x.txt", O_RDWR);
    printf("%d", fd);

    if (fd != -1)
    {
        write(fd, msg, 11);

        // lseek(fd, 0, SEEK_SET);
        read(fd, buffer, 11);

        printf("%s", buffer);
        close(fd);
    }
}

//pc
#include <stdio.h>
#include <stdlib.h>

int mutex = 1;
int full = 0;
int empty = 10, x = 0;

void producer()
{
    --mutex;
    ++full;
    --empty;
    x++;
    printf("\nProducer produces item %d", x);
    ++mutex;
}

void consumer()
{
    --mutex;
    --full;
    ++empty;
    printf("\nConsumer consumes item %d", x);
    x--;
    ++mutex;
}
int main()
{
    int n, i;
    printf("\n1. Press 1 for Producer"
           "\n2. Press 2 for Consumer"
           "\n3. Press 3 for Exit");

    while (1)
    {

        printf("\nEnter your choice:");
        scanf("%d", &n);
        switch (n)
        {
        case 1:
            if ((mutex == 1) && (empty != 0))
            {
                producer();
            }
            else
            {
                printf("Buffer is full!");
            }
            break;
        case 2:
            if ((mutex == 1) && (full != 0))
            {
                consumer();
            }
            else
            {
                printf("Buffer is empty!");
            }
            break;
        case 3:
            exit(0);
            break;
        }
    }
}
//ba

#include <stdio.h>
#include <stdbool.h>

int main() {
    int n, m;
    printf("Enter the number of processes: ");
    scanf("%d", &n);
    printf("Enter the number of resource types: ");
    scanf("%d", &m);

    int allocation[n][m], max[n][m], available[m], need[n][m], safeSequence[n];
    bool finish[n];

    // Input allocation matrix
    printf("Enter the allocation matrix:\n");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            scanf("%d", &allocation[i][j]);
        }
    }

    // Input maximum demand matrix
    printf("Enter the maximum demand matrix:\n");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            scanf("%d", &max[i][j]);
        }
    }

    // Input available resources
    printf("Enter the available resources:\n");
    for (int i = 0; i < m; i++) {
        scanf("%d", &available[i]);
    }

    // Calculate the need matrix
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            need[i][j] = max[i][j] - allocation[i][j];
        }
    }

    // Initialize finish array to false
    for (int i = 0; i < n; i++) {
        finish[i] = false;
    }

    // Apply Banker's Algorithm
    int count = 0;
    while (count < n) {
        bool found = false;
        for (int p = 0; p < n; p++) {
            if (!finish[p]) {
                bool canAllocate = true;
                for (int j = 0; j < m; j++) {
                    if (need[p][j] > available[j]) {
                        canAllocate = false;
                        break;
                    }
                }
                if (canAllocate) {
                    for (int k = 0; k < m; k++) {
                        available[k] += allocation[p][k];
                    }
                    safeSequence[count++] = p;
                    finish[p] = true;
                    found = true;
                }
            }
        }
        if (!found) {
            printf("The system is in an unsafe state.\n");
            return 0;
        }
    }

    printf("The system is in a safe state.\nSafe sequence is: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", safeSequence[i]);
    }
    printf("\n");

    return 0;
}


//pfifo

#include <stdio.h>

int main() {
    int n, m;
    printf("Enter the number of string values: ");
    scanf("%d", &n);
    int string[n];


    for (int i = 0; i < n; i++) {
        printf("Enter value %d: ", i + 1);
        scanf("%d", &string[i]);
    }

    printf("Enter the number of frames: ");
    scanf("%d", &m);
    int frames[m];

    for (int i = 0; i < m; i++) {
        frames[i] = -1; // Correctly initialize frames array
    }

    int hit = 0, fault = 0;
    int count = 0;
    for (int i = 0; i < n; i++) {
        int found = 0;
        for (int j = 0; j < m; j++) {
            if (frames[j] == string[i]) {
                found = 1;
                hit++;
                break;
            }
        }

        if (!found) {
            frames[count] = string[i];
            count++;
            if (count == m) {
                count = 0;
            }
            fault++;
        }
    }
 
    printf("Hits: %d, Faults: %d\n", hit, fault);
    return 0;
}

//pagging

#include <stdio.h>
#include <conio.h>
int main()
{
    int ms, ps, nop, np, rempages, i, j, x, y, pa, offset;
    int s[10], fno[10][20];

    printf("\nEnter the memory size -- ");
    scanf("%d", &ms);

    printf("\nEnter the page size -- ");
    scanf("%d", &ps);

    nop = ms / ps;
    printf("\nThe no. of pages available in memory are -- %d ", nop);

    printf("\nEnter number of processes -- ");
    scanf("%d", &np);
    rempages = nop;
    for (i = 1; i <= np; i++)

    {

        printf("\nEnter no. of pages required for p[%d]-- ", i);
        scanf("%d", &s[i]);

        if (s[i] > rempages)
        {

            printf("\nMemory is Full");
            break;
        }
        rempages = rempages - s[i];

        printf("\nEnter pagetable for p[%d] --- ", i);
        for (j = 0; j < s[i]; j++)
            scanf("%d", &fno[i][j]);
    }

    printf("\nEnter Logical Address to find Physical Address ");
    printf("\nEnter process no. and pagenumber and offset -- ");

    scanf("%d %d %d", &x, &y, &offset);

    if (x > np || y >= s[i] || offset >= ps)
        printf("\nInvalid Process or Page Number or offset");

    else
    {
        pa = fno[x][y] * ps + offset;
        printf("\nThe Physical Address is -- %d", pa);
    }
}



