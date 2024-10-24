# Homework 7 Linux CLI Practice


## Overview
This assignment is practice with some common Linux CLI tools.

### 1. wc -w lorem-ipsum.txt

![Q1](assets/hw7_screenshots/1.png)

### 2. wc -m lorem-ipsum.txt

![Q2](assets/hw7_screenshots/2.png)

### 3. wc -l lorem-ipsum.txt

![Q3](assets/hw7_screenshots/3.png)

### 4. sort -g file-sizes.txt
    This one was to big to screenshot so this is the bottom of the output 
![Q4](assets/hw7_screenshots/4.png)

### 5. sort -g -r file-sizes.txt
    This one was to big to screenshot so this is the bottom of the output
![Q5](assets/hw7_screenshots/5.png)

### 6. cut -d',' -f3 log.csv

![Q6](assets/hw7_screenshots/6.png)

### 7. cut -d',' -f2,3 log.csv

![Q7](assets/hw7_screenshots/7.png)

### 8. cut -d',' -f1,4 log.csv

![Q8](assets/hw7_screenshots/8.png)

### 9.  head -n 3 gibberish.txt

![Q9](assets/hw7_screenshots/9.png)

### 10. tail -n 2 gibberish.txt

![Q10](assets/hw7_screenshots/10.png)

### 11. tail -n+2 gibberish.txt

![Q11](assets/hw7_screenshots/11.png)

### 12. grep "and" gibberish.txt

![Q12](assets/hw7_screenshots/12.png)

### 13. grep -wn "we" gibberish.txt

![Q13](assets/hw7_screenshots/13.png)

### 14.  grep -oi -P "To \w+" gibberish.txt

![Q14](assets/hw7_screenshots/14.png)

### 15. grep -c "FPGAs" fpgas.txt

![Q15](assets/hw7_screenshots/15.png)

### 16. grep -P "(hot|not|cower|tower|smile|compile)" fpgas.txt

![Q16](assets/hw7_screenshots/16.png)

### 17. grep -rc -H "^--" hdl/

    I dont think "CPU topo ever appeared in dmesg
 ![Q17](assets/hw7_screenshots/17.png)

### 18. ls > ls-output.txt

![Q18](assets/hw7_screenshots/18.png)

### 19. sudo dmesg | grep "CPU topo"

![Q91](assets/hw7_screenshots/19.png)

### 20. find hdl/ -iname '*.vhd'

![Q20](assets/hw7_screenshots/20.png)

### 21. find hdl/ -iname '*.vhd' | xargs grep -oc  "^--" | wc -l

![Q21](assets/hw7_screenshots/21.png)

### 22. grep -n "FPGAs" fpgas.txt

![Q22](assets/hw7_screenshots/22.png)

### 23.  du -hc * | sort -rh | head -n 4

![Q23](assets/hw7_screenshots/23.png)


![All_done](assets/hw7_screenshots/done.png)