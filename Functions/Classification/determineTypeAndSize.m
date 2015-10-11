function [class,type,length,width] = determineTypeAndSize(vehicleClassifier,predictedVehicle)

    detectedVehicle = {'BicycleMotorcycle','BigTruck','Bus','Jeep','MiniTruckPickup','MiniVanSUV','PedicabTricycle','Sedan','Van'};
    detectedNonVehicle = {'Human','Road','Unknown'};

    [categoryIndex, categoryScores] = predict(vehicleClassifier, predictedVehicle);

    predictedVehicleLabel = vehicleClassifier.Labels(categoryIndex);
    predictedVehicleClass = strrep(mat2str(cell2mat(predictedVehicleLabel)),'''','');

    isVehicle = strcmp(predictedVehicleClass,detectedVehicle);
    isNonVehicle = strcmp(predictedVehicleClass,detectedNonVehicle);
    
    if any(isVehicle == 1)
       
        type = predictedVehicleClass;
    
        if strcmp(predictedVehicleClass,'BicycleMotorcycle')
            class = 'A';
            length = 2.15;
            width = 0.65;
        elseif strcmp(predictedVehicleClass,'BigTruck')
            class = 'D';
            length = 19.25;
            width = 2.65;
        elseif strcmp(predictedVehicleClass,'Bus')
            class = 'D';
            length = 14.5;
            width = 2.55;
        elseif strcmp(predictedVehicleClass,'Jeep')           
            class = 'C';
            length = 6.95;
            width = 1.85;
        elseif strcmp(predictedVehicleClass,'MiniTruckPickup')
            class = 'C';
            length = 6.4;
            width = 2;
        elseif strcmp(predictedVehicleClass,'MiniVanSUV')
            class = 'C';
            length = 6.4;
            width = 1.75;
        elseif strcmp(predictedVehicleClass,'PedicabTricycle')
            class = 'A';
            length = 2.15;
            width = 1.6;
        elseif strcmp(predictedVehicleClass,'Sedan')
            class = 'B';
            length = 6;
            width = 1.7;
        elseif strcmp(predictedVehicleClass,'Van')
            class = 'C';
            length = 7.95;
            width = 2;
        else
            class = 'NA';
            length = 0;
            width = 0;
        end
        
    elseif any(isNonVehicle == 1)
        type = predictedVehicleClass;
        class = 'NA';
        length = 0;
        width = 0;
    
    else
        type = 'NA';
        class = 'NA';
        length = 0;
        width = 0;
   
    end

end
