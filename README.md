# ecs-restart-helper
Restart helper for your microservice

Often times I find it rather tiring to go through each ECS Task and restart them one by one. So here's a little script that automatically goes through all tasks of a service and kill them one by one

### Pre Requisites 

Make sure you have a generate session token stored in `~/.aws/credentials`. This can be done by a variety of AWS CLI SSO tools out there


### Usage 

1. Once you have a valid session credentials, simply run the script 

```bash
./serviceRestart.sh
```

2. Select the appropriate *cluster* 

3. Select the service that needs restarted 

4. That's it! 

*Now you can continue working while your service is being restarted silently in the background 💩 💩 💩* 

