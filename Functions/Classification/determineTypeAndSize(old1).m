function [class,vehicleType,len,width,height] = determineTypeAndSize(vehicleClassifier, predictedVehicle)

    detectedVehicle = {'BicycleMotorcycle','BigTruck','Bus','Jeep','MiniTruck','MiniVanSUV','PedicabTricycle','Pickup','Sedan','Van','Truck'};
    detectedNonVehicle = {'Human','Road','Unknown'};

    [categoryIndex, categoryScores] = predict(vehicleClassifier, predictedVehicle);

    predictedVehicleLabel = vehicleClassifier.Labels(categoryIndex);
    predictedVehicleClass = strrep(mat2str(cell2mat(predictedVehicleLabel)),'''','');

    isVehicle = strcmp(predictedVehicleClass,detectedVehicle);
    isNonVehicle = strcmp(predictedVehicleClass,detectedNonVehicle);
    
    class = 'X';
    vehicleType = 'X';
    len = 0;
    width = 0;
    height = 0;
    
    if any(isVehicle == 1)
       
        vehicleType = predictedVehicleClass;
    
        if strcmp(predictedVehicleClass,'BicycleMotorcycle')
            class = 'A';
            len = 1;
            width = 2;
            height = 99;
        elseif strcmp(predictedVehicleClass,'BigTruck')
            class = 'D';
            len = 3;
            width = 4;
            height = 99;
        elseif strcmp(predictedVehicleClass,'Bus')
            class = 'D';
            len = 5;
            width = 6;
            height = 99;
        elseif strcmp(predictedVehicleClass,'Jeep')           
            class = 'C';
            len = 7;
            width = 8;
            height = 99;
        elseif strcmp(predictedVehicleClass,'MiniTruck')
            class = 'C';
            len = 9;
            width = 10;
            height = 99;
        elseif strcmp(predictedVehicleClass,'MiniVanSUV')
            class = 'C';
            len = 11;
            width = 12;
            height = 99;
        elseif strcmp(predictedVehicleClass,'PedicabTricycle')
            class = 'A';
            len = 13;
            width = 14;
            height = 99;
        elseif strcmp(predictedVehicleClass,'Pickup')
            class = 'C';
            len = 15;
            width = 16;
            height = 99;
        elseif strcmp(predictedVehicleClass,'Sedan')
            class = 'B';
            len = 18;
            width = 19;
            height = 99;
        elseif strcmp(predictedVehicleClass,'Van')
            class = 'C';
            len = 21;
            width = 22;
            height = 99;
        else
            class = 'X';
            len = 0;
            width = 0;
            height = 0;
        end
        
    elseif any(isNonVehicle == 1)
        disp(predictedVehicleClass);
    
    else
        disp('Neither a vehicle nor a non-vehicle.');
        disp(predictedVehicleClass);
    
    end

end
