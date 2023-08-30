using Ipopt

# include("ANN_input.jl")
include("ANN_input_true.jl")

# filename="input_data\\SA_results_$nBus.ods"
# converged_PF=ods_readall(filename;sheetsNames=["PF"],innerType="Matrix") #p g v θ
# for i in 1:nGens
#       nw_gens[i].gen_Pg_avl=converged_PF["PF"][:,1][i]
#       nw_gens[i].gen_V_set=converged_PF["PF"][:,3][i]
# end


# AC_SCOPF = Model(Ipopt.Optimizer)
# model_name=AC_SCOPF
# JuMP.bridge_constraints(model_name)=false
include("bonmin_solver.jl")


show(now() )
println("")
show("Model starts now")
(e, f, Pg, Qg, pen_ws, pen_lsh, p_fl_inc, p_fl_dec, p_ch, p_dis, soc)                      =variables_n(model_name)
(e_c, f_c, Pg_c, Qg_c, pen_ws_c, pen_lsh_c, p_fl_inc_c ,p_fl_dec_c, p_ch_c, p_dis_c, soc_c)=variables_c(model_name)
# for i in 1:6
    @variable(model_name, ann_input[i=1:6], lower_bound=min_input[i], upper_bound=max_input[i])
    @variable(model_name, sc[i=1:3], Bin)
# end

show(now())
println("")
show("variables are generated")

(vol_const_nr)=voltage_cons_n(model_name,"range")
(vol_const_cn)=voltage_cons_c(model_name,"range")
gen_limits_n(model_name,"range")
gen_limits_c(model_name,"range")

FL_cons_normal(model_name)
FL_cons_contin(model_name)

storage_cons_normal(model_name)
storage_cons_contin(model_name)
show(now())
println("")
show("volt+gnelim+fl+str are generated")
(pinj_dict,qinj_dict)        =line_expression_n(model_name)
show(now())
println("")
show("line expr normal")
(pinj_dict_c,qinj_dict_c)=   line_expression_c(model_name)
show(now())
println("")
show("line expr contin")
(active_power_balance_normal)=active_power_bal_n(model_name,pinj_dict)
show(now())
println("")
show("power bal norm")
(active_power_balance_contin)=active_power_bal_c(model_name,pinj_dict_c)
show(now())
println("")
show("power bal contin")
(reactive_power_balance_normal)=reactive_power_bal_n(model_name,qinj_dict)
show(now())
println("")
show("react power bal normal")
(reactive_power_balance_contin)=reactive_power_bal_c(model_name,qinj_dict_c)
show(now())
println("")
show("react power bal contin")
(line_flow_normal_s,line_flow_normal_r)=line_flow_n(model_name,pinj_dict,qinj_dict,0 )# "full"
(line_flow_contin_s,line_flow_contin_r)=line_flow_c(model_name,pinj_dict_c,qinj_dict_c,0 )# "full"
show(now())
println("")
show("line flow all")
# longitudinal_current_normal(model_name)
# longitudinal_current_contin(model_name)

coupling_constraint(model_name)

include("ANN.jl")

(total_cost,cost_gen,cost_pen_lsh,cost_fl,cost_str,cost_pen_ws,cost_pen_lsh_c,cost_pen_ws_c,cost_fl_c,cost_str_c)=objective_SCOPF(model_name)

show(now())
println("")
show("coupling+obj and Optimizer starts ")

optimize!(model_name)
show(now())
println(termination_status(model_name))

println("")
show("optimizer finished")
println("Objective value", JuMP.objective_value(model_name))
println("Solver Time ", JuMP.solve_time(model_name))


# (bounded_line_dual_val, bounded_line_dual_val_contin)=dualizing_non_linear()
# ods_write("input_data\\binding_line_flow_$nBus.ods",Dict(("LFlow_normal",1,1)=>[ collect(keys(bounded_line_dual_val)) collect(values(bounded_line_dual_val))]) )
# ods_write("input_data\\binding_line_flow_$nBus.ods",Dict(("LFlow_contin",1,1)=>[ collect(keys(bounded_line_dual_val_contin)) collect(values(bounded_line_dual_val_contin))]) )
# # #
# (v_sq,voltage_gen,volt_ang,v_sq_c,voltage_gen_c,volt_ang_c)=rect_to_polar("contin")
# # # #
# # # v_gen=[voltage_gen[i] for i in 1:nBus if ~isempty(findall(x->x==i, bus_data_gsheet))]
# # # v_ang=[volt_ang[i] for i in 1:nBus if ~isempty(findall(x->x==i, bus_data_gsheet))]
# # #
# # # ods_write("input_data\\SA_results_$nBus.ods",Dict(("PF",1,1)=>[value.(Pg[1,1,:]) value.(Qg[1,1,:]) v_gen v_ang]) )
# # #
#
# (input_normal,input_contin,power_flow_normal_result2,power_flow_contin_result2)=power_flow("all","non_initial", "out_of_OPF","v_sqr","v_sqr","contin")
# # power_flow("normal/contin/all","initial/non_initial", "out_of_PF/out_of_OPF",0 if out of Pf and v_sqr/v_pol if out of opf,0 if out of SA and v_sqr/v_pol if out of contin, "contin/SA")
