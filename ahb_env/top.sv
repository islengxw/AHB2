/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 11 Sept 2015
 Author: Mayur Kubavat
 
 Module: TOP
 Filename: top.sv
**********************************************************/

module top;

        `include "uvm_macros.svh"
        import uvm_pkg::*;
        import ahb_test_pkg::*;

        logic clock;
        logic clock_s;

        initial
        begin
                clock = 0;
                forever #10 clock = ~clock;
        end
		initial begin
				clock_s = 0;
                forever #20 clock_s = ~clock_s;
		end

        ahb_intf intf(clock, clock_s);
cmsdk_ahb_to_ahb_apb_async #(.MW(4)) aon_ahb2ahb(
				       // Outputs
				       .HRDATAS		(intf.HRDATA),
				       .HREADYOUTS	(intf.HREADY),
				       .HRESPS		(intf.HRESP),
				       .HADDRM		(intf.HADDR_S),
				       .HBURSTM		(intf.HBURST_S),
				       .HMASTLOCKM	(),
				       .HPROTM		(),
				       .HSIZEM		(intf.HSIZE_S),
				       .HTRANSM		(intf.HTRANS_S),
				       .HWDATAM		(intf.HWDATA_S),
				       .HWRITEM		(intf.HWRITE_S),
				       .HMASTERM	(),
				       .PADDRM		(),
				       .PENABLEM	(),
				       .PPROTM		(),
				       .PSELM		(),
				       .PSTRBM		(),
				       .PWDATAM		(),
				       .PWRITEM		(),
				       .PMASTERM	(),
				       .HACTIVEM	(),	//need check 20200430
				       .PACTIVEM	(),
				       // Inputs
				       .HCLKS		(intf.HCLK),
				       .HRESETSn	(intf.HRESETn),
				       .HADDRS		(intf.HADDR),
				       .HBURSTS		(intf.HBURST),
				       .HMASTLOCKS	(1'b0),
				       .HPROTS		(4'b0),
				       .HREADYS		(intf.HREADY),
				       .HSELAHBS	(1'h1),
				       .HSELAPBS	(1'h0),
				       .HSIZES		(intf.HSIZE),
				       .HTRANSS		(intf.HTRANS),
				       .HWDATAS		(intf.HWDATA),
				       .HWRITES		(intf.HWRITE),
				       .HMASTERS	(4'hf),
				       .HCLKM		(intf.HCLK_S),
				       .HRESETMn	(intf.HRESETn),
				       .HRDATAM		(intf.HRDATA_S),
				       .HREADYM		(intf.HREADY_S),
				       .HRESPM		(intf.HRESP_S),
				       .PRDATAM		(32'h0),
				       .PREADYM		(intf.HREADY_S),
				       .PSLVERRM	(1'h0));		
					//dump fsdb
  		 initial begin
 		  $fsdbDumpfile("chip.fsdb");
 		  $fsdbDumpvars(0,top);
  		 end

        initial
        begin
                uvm_config_db#(virtual ahb_intf)::set(null, "*", "ahb_intf", intf);

                run_test();

        end

endmodule

