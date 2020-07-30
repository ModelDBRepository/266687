function [ output ] = outputFunction(membranePotential, outV12, outK )
%outputFunction 

output=(1+exp((membranePotential-outV12)./outK)).^(-1);
    if membranePotential <= -60
        output = 0;
    end
end

