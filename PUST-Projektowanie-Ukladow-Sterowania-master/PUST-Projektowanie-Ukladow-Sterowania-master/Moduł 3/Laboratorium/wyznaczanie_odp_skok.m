function test_sterowania()
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM4 % initialise com port
    step_response=[];
    h = animatedline();
    k = 1;
    u = 80;
    y = [];
    while(1)
        %% obtaining measurements
        measurements = readMeasurements(1); % read measurements from 1 to 1
        
        %% processing of the measurements and new control values calculation
        disp(measurements);
        y(k)=[step_response measurements(1)]
        
        save('step_response_80');
        %% sending new values of control signals
        sendNonlinearControls(u);
        sendControls([1], ... send for these elements
                     [50]);  % new corresponding control valuesdisp(measurements); % process measurements
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
        addpoints(h, k, y(k));
        drawnow
        k = k + 1;
    end
end

% ypp = 33.8;