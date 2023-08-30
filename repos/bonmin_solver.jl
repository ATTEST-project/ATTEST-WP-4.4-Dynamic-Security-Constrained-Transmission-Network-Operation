using  AmplNLWriter



#WARNING: did you double click on ampl.exe and bonmin.exe prioir to this stage????
optimizer  = AmplNLWriter.Optimizer

   AC_SCOPF = Model(() -> AmplNLWriter.Optimizer("C:\\bonmin-win64\\ampl.mswin64\\bonmin.exe"))

# AC_SCOPF = Model()

model_name=AC_SCOPF
JuMP.bridge_constraints(model_name)=false
# set_optimizer_attributes(model_name,"mu_strategy"=>"adaptive")
set_optimizer_attribute(model_name, "bonmin.nlp_solver", "Ipopt")
    set_optimizer_attribute(model_name,"bonmin.algorithm", "B-BB")
    set_optimizer_attribute(model_name,"bonmin.nlp_failure_behavior", "stop")
    set_optimizer_attribute(model_name,"bonmin.pump_for_minlp", "yes")
    set_optimizer_attribute(model_name,"bonmin.ecp_abs_tol", 0.001)
    set_optimizer_attribute(model_name,"bonmin.allowable_gap",1e-3)
    set_optimizer_attribute(model_name,"bonmin.allowable_fraction_gap",5e-2)
    set_optimizer_attribute(model_name,"bonmin.integer_tolerance", 1e-3)
    set_optimizer_attribute(model_name,"bonmin.time_limit",3600)
    set_optimizer_attribute(model_name,"file_print_level",5)
    set_optimizer_attribute(model_name,"bonmin.variable_selection","strong-branching")
    set_optimizer_attribute(model_name,"print_level",2)
