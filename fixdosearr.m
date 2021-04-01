%helper function for the script that simulates patient response.
%returns an array of each day a patient will recieve a PAN dose for the
%entire treatment period
function [dondf] = fixdosearr(doseondays,cyclenum)
%function takes in a dose schedule and returns an array of the doses ad
dondf = zeros(1,length(doseondays)*cyclenum);
index = 1;
for i = 1:1:length(dondf)
    if index>length(doseondays)
        index = 1;
    end
   dondf(i)=doseondays(index); 
   index = index+1; 
end
end