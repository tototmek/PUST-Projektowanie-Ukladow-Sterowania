function test_sterowania()
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM4 % initialise com port
    step_response=[];
    h = animatedline();
    k = 1;
    while(1)
        %% obtaining measurements
        measurements = readMeasurements(1); % read measurements from 1 to 1
        
        %% processing of the measurements and new control values calculation
        disp(measurements);
        step_response=[step_response measurements(1)];
        
        %save('step_response_dupa')
        %% sending new values of control signals
        sendControlsToG1AndDisturbance(25, 0)
        sendControls([1], ... send for these elements
                     [50]);  % new corresponding control valuesdisp(measurements); % process measurements
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
        addpoints(h, k, step_response(k));
        drawnow
        k = k + 1;
    end
end

%Y_pp = 33.43
%G1 = 25
%Z = 0

%Y_k = 39.1200
%G1 = 25
%Z = 30

%Y_k = 45.37
%G1 = 25
%Z = 60

%Y_k =
%G1 = 25
%Z = 45