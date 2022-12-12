function test_sterowania()
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
    step_response=[];
    h = animatedline("Marker", "o");
    k = 0;
    while(1)
        k = k+1;
        %% obtaining measurements
        measurements = readMeasurements(1); % read measurements from 1 to 1
        
        %% processing of the measurements and new control values calculation
        disp(measurements);
        step_response=[step_response measurements(1)];
        save('step_response_udupa')
        %% sending new values of control signals
        sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                     [ 50, 0, 0, 0, 25, 0]);  % new corresponding control valuesdisp(measurements); % process measurements
        
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
        addpoints(h, k, step_response(k));
        drawnow
    end
end