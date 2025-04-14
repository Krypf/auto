#%%
from datetime import datetime, time, timedelta, date

# Dictionary of execution times for each day
execution_times = {
    "Monday": time(13, 30),
    "Tuesday": time(13, 31),
    "Wednesday": time(13, 32),
    "Thursday": time(13, 33),
    "Friday": time(13, 34),
}
#%%

# Mapping from day name to the corresponding letter

def days_mapping_cron(day):
    return day[:3].lower()

def generate_cron_jobs():
    # List to store the cron job lines
    cron_jobs = []

    # Loop through each day and execution time to generate the cron job
    for day, execution_time in execution_times.items():
        # Format the time in HH:MM format
        time_str = execution_time.strftime("%M %H * *")
        
        # Build the cron job for this day
        cron_command = f"{time_str} {days_mapping_cron(day)} cd ~/arxiv_bot ; /bin/sh run.sh"
        cron_jobs.append(cron_command)

    # Join the cron jobs into a single string with newlines
    cron_jobs_text = "\n".join(cron_jobs)
    
    # Write the cron jobs to a file
    # execute in auto/
    with open("arXiv/arxiv_bot_cron_jobs.txt", "w") as f:
        f.write(cron_jobs_text)

    # Output the cron jobs to the console (optional)
    print(cron_jobs_text)

# Mapping from day name to the corresponding letter
def days_mapping_pmset(day):
    return day[:1]

def write_pmset_su_crontab():
    # List to store the lines for the output file
    output_lines = []

    # Loop through each day and execution time to calculate the adjusted time
    for day, execution_time in execution_times.items():
        # Get the corresponding day letter and formatted time string
        day_one_letter = days_mapping_pmset(day)
        day_three_letters = days_mapping_cron(day)
        hour_str = execution_time.strftime("%H")
        minute_str = execution_time.strftime("%M")
        # Subtract 1 minute from the execution time
        adjusted_time = (datetime.combine(date.today(), execution_time) - timedelta(minutes=2)).time()
        time_str = adjusted_time.strftime("%H:%M:%S")
        # Format the time in HH:MM:00 format

        output_lines.append(f"{minute_str} {hour_str} * * {day_three_letters} sudo pmset repeat wakeorpoweron {day_one_letter} {time_str}")

    # Write the generated cron jobs to a file
    with open("pmset_cron_jobs.txt", "w") as f:
        f.write("\n".join(output_lines))
    # Add a line indicating the need for sudo privileges to run the file
    output_lines.append("\n# This script requires sudo privileges to execute.")

    # Output the result to the console (optional)
    print("\n".join(output_lines))
    
if __name__ == '__main__':
    # Call the function to generate the cron jobs
    generate_cron_jobs()
