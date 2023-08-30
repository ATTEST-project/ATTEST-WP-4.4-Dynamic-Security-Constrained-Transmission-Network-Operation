# using JuMP
# ann=Model()

#----------------------------------Constraints over Reactive generation----------------------------------
# when the synchronous condensers are off, aprat from active power which is set to zero in the input data, the reactive power should also be zero.
sync_con_gsheet=[34,37,38]
@constraint(model_name, [t=1:nTP,i in sync_con_gsheet ], Qg[t,indexin(i, bus_data_gsheet)[1]]>=qg_min[indexin(i, bus_data_gsheet)[1]]* sc[indexin(i, sync_con_gsheet)[1]]  )
@constraint(model_name, [t=1:nTP,i in sync_con_gsheet ], Qg[t,indexin(i, bus_data_gsheet)[1]]<=qg_max[indexin(i, bus_data_gsheet)[1]]* sc[indexin(i, sync_con_gsheet)[1]]  )



#----------------------Expressions over ANN inputs--------------------
@constraint(model_name, ann_input[1]==sbase*sum(Pg[t,i] for t in 1:nTP, i in 1:nGens )  )

@constraint(model_name, ann_input[2]==sbase*(sum(prof_PRES)-sum(pen_ws)  ) )

# @variable(model_name, sc[i=1:3], Bin)
@constraint(model_name, ann_input[3]==866.4* sc[1]  )
@constraint(model_name, ann_input[4]==1619.8*sc[2]  )
@constraint(model_name, ann_input[5]==2300.0*sc[3]  )
@constraint(model_name, ann_input[6]==20890.3  )
# @constraint(model_name, ann_input[6]==866.4*sc[1]+1619.8*sc[2]+2300.0*sc[3]  )

T_WIH=WIH'

normalized=@expression(model_name, [i=1:6],(ann_input[i]-min_input[i])/(max_input[i]-min_input[i]))


VH=@expression(model_name,T_WIH*normalized)
H= @expression(model_name, VH+BH)

T_WHO=WHO'
VO=@NLexpression(model_name, [i=1:size(H[:,1],1), j=1:size(T_WHO[:,1],1)], T_WHO[j,i]/(1+exp(-(H[i]) ))  )

# VO=@NLexpression(model_name,T_WHO*AH)
O1=@NLexpression(model_name,BO[1]+sum(VO[i,1] for i in 1:size(VO[:,1],1)))
O2=@NLexpression(model_name,BO[2]+sum(VO[i,2] for i in 1:size(VO[:,1],1)))

rocof=@NLexpression(model_name,0.159737745+ O1*(1.835981286-0.159737745) )
nadir=@NLexpression(model_name,0.057258479+ O2*(1.017362684-0.057258479) )



#---------------------------Constraints over the ANN ------------------------------------
# @NLconstraint(model_name,rocof<=1.835981286)
# @NLconstraint(model_name,rocof>=0.159737745)
#
# @NLconstraint(model_name,nadir<=1.017362684)
# @NLconstraint(model_name,nadir>=0.057258479)

@NLconstraint(model_name,rocof<=1)
@NLconstraint(model_name,nadir<=0.8)

# for i in 1:3
# fix(sc[i],0)
# end
