ann_input_final=zeros(6,1)
for i in 1:6
    ann_input_final[i]=value.(ann_input[i])
end




normalized=@expression(model_name, [i=1:6],(ann_input_final[i]-min_input[i])/(max_input[i]-min_input[i]))

VH=@expression(model_name,T_WIH*normalized)
H= @expression(model_name, VH+BH)

AH=@expression(model_name,[i=1:12], 1/(1+exp(-(H[i]) ) ) )

T_WHO=WHO'

VO=@expression(model_name,T_WHO*AH)
O=@expression(model_name,VO+BO)


Rocof=0.159737745+ value.(O)[1]*(1.835981286-0.159737745)
Nadir=0.057258479+ value.(O)[2]*(1.017362684-0.057258479)
