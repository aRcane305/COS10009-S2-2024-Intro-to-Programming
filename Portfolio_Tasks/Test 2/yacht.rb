
module Rig
    Bermuda, Ketch, Cutter, Gaff = *0..3
end

Rig_names = ["Bermuda", "Ketch", "Cutter", "Gaff"]

module Hull
    Round, Flat, V = *0..2
end

Hull_names = ["Round Bottom", "Flat Bottom", "V-Shaped"]

Ship = Struct.new(:name, :hull, :construction, :rig)