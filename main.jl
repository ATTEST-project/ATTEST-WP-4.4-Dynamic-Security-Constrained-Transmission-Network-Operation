using JuMP,OdsIO,MathOptInterface,Dates,LinearAlgebra
# using Ipopt
# using BenchmarkTools
using CPLEX
# using SCIP       # It is not useful for our purpose. Mianly deals with the feasibility problem.
# using AmplNLWriter
# using Cbc

#-------------------Accessing current folder directory--------------------------
println(pwd());
cd(dirname(@__FILE__))
println(pwd());

# files = cd(readdir, string(pwd(),"\\Network_Data"))
#--------------------Read Data from the Excel file------------------------------
@time begin
# filename = "case_template_CR_L1_EX1.ods"
# filename = "case5_bus_new_EX1.ods"
# filename = "input_data/case_template_port_modified_R1_SA_Reduced.ods"
# filename = "input_data/case_template_port_modified_R1.ods"
# filename = "input_data/case60_bus_new_wind_Equal.ods"
filename = "input_data/case39_bus_NEW.ods"

# filename = "input_data/case5_bus_new.ods"
filename_scenario= "input_data/scenario_gen.ods"
# filename_scenario= "scenario_gen.ods"
# filename = "case_34_baran_modf.ods"
include("data_preparation/data_types.jl")      # Reading the structure of network related fields

include("data_preparation/data_types_contingencies.jl")

include("data_preparation/data_reader.jl")     # Function setting the data corresponding to each network quantity

include("data_preparation/interface_excel.jl") # Program saving all the inforamtion related to each entity of a power system


#-----------functions---------------------
include("functions/network_topology_functions.jl")

include("functions/AC_SCOPF_functions.jl")

# include("functions/PF_functions_common.jl")
# include("functions/PF_functions_n.jl")
# include("functions/PF_functions_c.jl")

# include("functions/tractable_SCOPF_functions.jl")




#----------------------- Formatting of Network Data ----------------------------
include("data_preparation/contin_scen_arrays.jl")

include("data_preparation/node_data_func.jl")

show("Initial functions are compiled. ")

end
#--- this one solves an accurate OPF or SCOPF
include("repos/AC_SC_OPF.jl")


# Rocof=0.159737745+ value.(O)[1]*(1.835981286-0.159737745)
# Nadir=0.057258479+ value.(O)[2]*(1.017362684-0.057258479)
#
# show("Rocof=$Rocof")
# println("")
# show("Nadir=$Nadir")
include("repos/ANN_output.jl")
