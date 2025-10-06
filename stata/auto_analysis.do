clear all
set more off

* Example short test job
sysuse auto, clear
summarize price mpg weight

regress price mpg weight

display "Job completed successfully!"
exit, clear
