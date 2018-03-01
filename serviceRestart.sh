#!/bin/bash 

# We first need to ensure that 
echo "AWS Auto Restart Agent"
echo "Select a cluster"


getService () 

{
   services=`aws ecs list-services --cluster $1 | jq ".serviceArns[]" | tr -d '"'`
   services=`echo $services "EXIT"`
   echo " "
   echo " Please select a service: "
   select sv in $services
   do {
        if [[ $sv = "EXIT" ]]; then
            exit 0
        else
            killTask $1 $sv
        fi  
   }
   done 
}

killTask () 

{
    echo "Are you sure you want to restart $sv?"
    confirm=( "Yes" "No" )
    select choice in ${confirm[@]}
    do 
    {
    
        if [[ $choice = "No" ]]; then
            exit 0
        else {
            tasks=(`aws ecs list-tasks --cluster $1 --service $2 | jq ".taskArns[]"`)
            numTasks=${#tasks[@]} 
            for i in "${tasks[@]}"
            do
                task2kill=$(echo $i | tr -d '"')
                ((numTasks-=1))
                echo "Killing $task2kill -- $numTasks left"
                aws ecs stop-task --cluster $1 --task $task2kill > /dev/null 2>&1
                sleep 25
            done
            exit 0 
        }
        fi
    }
    done

}


clusters=`aws ecs list-clusters | jq ".clusterArns[]" | tr -d '"' ` 
clusters=`echo $clusters "EXIT"`
echo " "
echo " Please select a cluster: "
select cluster in $clusters
do 
    {   
        if [[ $cluster = "EXIT" ]]; then
            exit 0
        else
            getService $cluster
        fi 
    }
    
done