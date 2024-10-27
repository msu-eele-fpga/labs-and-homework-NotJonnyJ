#include <stdio.h>  
#include <unistd.h>  

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

#include <signal.h>

const uint32_t HPS_CONTROL_ADDRESS = 0xFF200000;
const uint32_t LED_ADDRESS = 0xFF200004;
const uint32_t BASE_PERIOD_ADDRESS = 0xFF200008;

static volatile int running = 1;

void intHandler(int dummy) 
{
    printf("\nResetting FPGA back to Hardware Control Mode\n");
    running = 0;
}




  
int main(int argc, char *argv[])  
{
    signal(SIGINT, intHandler);

    const size_t PAGE_SIZE = sysconf(_SC_PAGE_SIZE);

    int fd = open("/dev/mem", O_RDWR | O_SYNC);

    if(fd == -1){
        fprintf(stderr, "failed to open /dev/mem. \n");
        //return 1;
    }

    uint32_t page_aligned_addr = HPS_CONTROL_ADDRESS & ~(PAGE_SIZE - 1);
    printf("memory address:\n");
    printf("----------------------------------------\n");
    printf("page aligned address = 0x%x\n", page_aligned_addr);
    
    uint32_t *page_virtual_addr = (uint32_t *)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, page_aligned_addr);

    if(page_virtual_addr == MAP_FAILED)
    {
    fprintf(stderr, "failed to map memory.\n");
    //return 1;

    }
    printf("page_virtual_addr = %p\n", page_virtual_addr);

    uint32_t led_offset_in_page = LED_ADDRESS & (PAGE_SIZE - 1);
    uint32_t hps_offset_in_page = HPS_CONTROL_ADDRESS & (PAGE_SIZE - 1);
    uint32_t base_offset_in_page = BASE_PERIOD_ADDRESS & (PAGE_SIZE - 1);
    printf("led offset in page = 0x%x\n", led_offset_in_page);
    printf("hps offset in page = 0x%x\n", hps_offset_in_page);
    printf("base rate offset in page = 0x%x\n", base_offset_in_page);


    volatile uint32_t *led_target_virtual_addr = page_virtual_addr + led_offset_in_page/sizeof(uint32_t *);
    volatile uint32_t *hps_target_virtual_addr = page_virtual_addr + hps_offset_in_page/sizeof(uint32_t *);
    volatile uint32_t *base_target_virtual_addr = page_virtual_addr + base_offset_in_page/sizeof(uint32_t *);

    printf("led_targer_virtual_addr = %p\n", led_target_virtual_addr);
    printf("hps_targer_virtual_addr = %p\n", hps_target_virtual_addr);
    printf("base targer_virtual_addr = %p\n", base_target_virtual_addr);
    printf("---------------------------------------------\n");
    printf("\n");

    

    /*
    if(is_write){
        const uint32_t VALUE = strtoul(argv[2], NULL, 0);
        *target_virtual_addr = VALUE;
    }
    else{
        printf("\nvalue at 0x%x = 0x%x\n", ADDRESS, *target_virtual_addr);

    }
    */

    int opt; 
      
    // put ':' in the starting of the 
    // string so that program can  
    //distinguish between '?' and ':'  
    while((opt = getopt(argc, argv, "hvpf::b")) != -1 && running == 1)  
    {  
        switch(opt)  
        {   
            case 'h':  
                // Help Section
                printf("led-patterns [-h] [-v] [-p FOO BAR] [-f FOO]\n");
                printf("\n");
                printf("-h      Show this output for help\n");
                printf("-v      Verbose output\n");
                printf("            shows LED pattern and Display Time\n");
                printf("            EX Output: LED pattern = 01010101 Display time = 500 msec\n");
                printf("-p      Takes input for a new LED Pattern\n");
                printf("            EX Input: ./led-patterns pattern1 time1 pattern2 time2 pattern3 time3\n");
                printf("-f      Takes input for a new LED Pattern from file\n"); 
                break;  

            case 'v':  
                // Verbose 
                // print what the LED pattern is as a binary string and how long it is being displayed for
                // EX: LED pattern = 01010101 Display time = 500 msec
                printf("used -v \n");  
                break;  

            case 'p':  

                // Makes a patterns
                // intput : pattern1 time1 pattern2 time2 pattern3 time3

                // Parse inputs
                while(true)
                {
                    for(int i = optind; i < argc - 1; i += 2)
                    {
                        if (i + 1 < argc) 
                        {
                            uint32_t pattern = strtoul(argv[i], NULL, 0);
                            uint32_t display_time = strtoul(argv[i + 1], NULL, 0);
                            printf("LED pattern: 0x%x, Display time: %u ms\n", pattern, display_time);

                            *led_target_virtual_addr = pattern;
                            printf("Pattern 0x%x written to FPGA.\n", pattern);

                            sleep(display_time*0.001); 
                        } else 
                        {
                            printf("Incomplete pattern/time pair\n");
                            return 1;
                            break;
                            
                        }
                    }
                }
                
                printf("used -p \n");  
                //printf("filename: %s\n", optarg);  
                break;

            case 'f':  
                //For a file input 
                printf("used -f \n");  
                break;

            case '?':  
                printf("unknown option: %c\n", optopt); 
                break;  
        }  
    }  
      
    // optind is for the extra arguments 
    // which are not parsed 
    for(; optind < argc; optind++)
    {      
        printf("\nSomethings Broked! What did you do??? \n\n");  
    } 
      
    return 0; 
} 