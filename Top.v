module Maindec(
  input  [5:0] op,
  output       memtoreg,
  output       memwrite,
  output       branch,
  output       alusrc,
  output       regdst,
  output       regwrite,
  output       jump,
  output [1:0] aluop
);
  wire  op1 = op == 6'h0; // @[Maindec.scala 17:16]
  wire  op2 = op == 6'h23; // @[Maindec.scala 18:16]
  wire  op3 = op == 6'h2b; // @[Maindec.scala 19:16]
  wire  op4 = op == 6'h4; // @[Maindec.scala 20:16]
  wire  op5 = op == 6'h8; // @[Maindec.scala 21:16]
  wire  op6 = op == 6'h2; // @[Maindec.scala 22:16]
  wire [8:0] _controls_T = op1 ? 9'h182 : 9'h0; // @[Mux.scala 27:73]
  wire [8:0] _controls_T_1 = op2 ? 9'h148 : 9'h0; // @[Mux.scala 27:73]
  wire [6:0] _controls_T_2 = op3 ? 7'h50 : 7'h0; // @[Mux.scala 27:73]
  wire [5:0] _controls_T_3 = op4 ? 6'h21 : 6'h0; // @[Mux.scala 27:73]
  wire [8:0] _controls_T_4 = op5 ? 9'h140 : 9'h0; // @[Mux.scala 27:73]
  wire [2:0] _controls_T_5 = op6 ? 3'h4 : 3'h0; // @[Mux.scala 27:73]
  wire [8:0] _controls_T_6 = _controls_T | _controls_T_1; // @[Mux.scala 27:73]
  wire [8:0] _GEN_0 = {{2'd0}, _controls_T_2}; // @[Mux.scala 27:73]
  wire [8:0] _controls_T_7 = _controls_T_6 | _GEN_0; // @[Mux.scala 27:73]
  wire [8:0] _GEN_1 = {{3'd0}, _controls_T_3}; // @[Mux.scala 27:73]
  wire [8:0] _controls_T_8 = _controls_T_7 | _GEN_1; // @[Mux.scala 27:73]
  wire [8:0] _controls_T_9 = _controls_T_8 | _controls_T_4; // @[Mux.scala 27:73]
  wire [8:0] _GEN_2 = {{6'd0}, _controls_T_5}; // @[Mux.scala 27:73]
  wire [8:0] controls = _controls_T_9 | _GEN_2; // @[Mux.scala 27:73]
  assign memtoreg = controls[3]; // @[Maindec.scala 62:23]
  assign memwrite = controls[4]; // @[Maindec.scala 61:23]
  assign branch = controls[5]; // @[Maindec.scala 60:21]
  assign alusrc = controls[6]; // @[Maindec.scala 59:21]
  assign regdst = controls[7]; // @[Maindec.scala 58:21]
  assign regwrite = controls[8]; // @[Maindec.scala 57:23]
  assign jump = controls[2]; // @[Maindec.scala 63:19]
  assign aluop = controls[1:0]; // @[Maindec.scala 64:20]
endmodule
module Aludec(
  input  [5:0] funct,
  input  [1:0] aluop,
  output [2:0] alucontrol
);
  wire [2:0] _GEN_1 = funct == 6'h25 ? 3'h1 : 3'h7; // @[Aludec.scala 31:{37,49}]
  wire [2:0] _GEN_2 = funct == 6'h24 ? 3'h0 : _GEN_1; // @[Aludec.scala 30:{37,49}]
  wire [2:0] _GEN_3 = funct == 6'h22 ? 3'h6 : _GEN_2; // @[Aludec.scala 29:{37,49}]
  wire [2:0] _GEN_4 = funct == 6'h20 ? 3'h2 : _GEN_3; // @[Aludec.scala 28:{37,49}]
  wire [2:0] _GEN_5 = aluop == 2'h1 ? 3'h6 : _GEN_4; // @[Aludec.scala 26:{31,43}]
  assign alucontrol = aluop == 2'h0 ? 3'h2 : _GEN_5; // @[Aludec.scala 25:{31,43}]
endmodule
module Floprc(
  input        clock,
  input        reset,
  input        flush,
  input  [7:0] d,
  output [7:0] q
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] q_REG; // @[Floprc.scala 12:15]
  assign q = q_REG; // @[Floprc.scala 12:5]
  always @(posedge clock) begin
    if (reset) begin // @[Floprc.scala 12:15]
      q_REG <= 8'h0; // @[Floprc.scala 12:15]
    end else if (flush) begin // @[Floprc.scala 11:17]
      q_REG <= 8'h0;
    end else begin
      q_REG <= d;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_REG = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Flopr(
  input        clock,
  input        reset,
  input  [2:0] d,
  output [2:0] q
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] q_REG; // @[Flopr.scala 11:15]
  assign q = q_REG; // @[Flopr.scala 11:5]
  always @(posedge clock) begin
    if (reset) begin // @[Flopr.scala 11:15]
      q_REG <= 3'h0; // @[Flopr.scala 11:15]
    end else begin
      q_REG <= d; // @[Flopr.scala 11:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_REG = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Flopr_1(
  input        clock,
  input        reset,
  input  [1:0] d,
  output [1:0] q
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] q_REG; // @[Flopr.scala 11:15]
  assign q = q_REG; // @[Flopr.scala 11:5]
  always @(posedge clock) begin
    if (reset) begin // @[Flopr.scala 11:15]
      q_REG <= 2'h0; // @[Flopr.scala 11:15]
    end else begin
      q_REG <= d; // @[Flopr.scala 11:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_REG = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Ctrl(
  input        clock,
  input        reset,
  input  [5:0] op,
  input  [5:0] funct,
  input        flushE,
  input        zero,
  output       memtoregE,
  output       memtoregM,
  output       memtoregW,
  output       memwriteM,
  output       branch,
  output       pcsrc,
  output       alusrc,
  output       regdstE,
  output       regwriteE,
  output       regwriteM,
  output       regwriteW,
  output       jump,
  output [2:0] alucontrol
);
  wire [5:0] md_op; // @[Ctrl.scala 28:19]
  wire  md_memtoreg; // @[Ctrl.scala 28:19]
  wire  md_memwrite; // @[Ctrl.scala 28:19]
  wire  md_branch; // @[Ctrl.scala 28:19]
  wire  md_alusrc; // @[Ctrl.scala 28:19]
  wire  md_regdst; // @[Ctrl.scala 28:19]
  wire  md_regwrite; // @[Ctrl.scala 28:19]
  wire  md_jump; // @[Ctrl.scala 28:19]
  wire [1:0] md_aluop; // @[Ctrl.scala 28:19]
  wire [5:0] ad_funct; // @[Ctrl.scala 38:19]
  wire [1:0] ad_aluop; // @[Ctrl.scala 38:19]
  wire [2:0] ad_alucontrol; // @[Ctrl.scala 38:19]
  wire  dereg_clock; // @[Ctrl.scala 42:22]
  wire  dereg_reset; // @[Ctrl.scala 42:22]
  wire  dereg_flush; // @[Ctrl.scala 42:22]
  wire [7:0] dereg_d; // @[Ctrl.scala 42:22]
  wire [7:0] dereg_q; // @[Ctrl.scala 42:22]
  wire  emreg_clock; // @[Ctrl.scala 52:22]
  wire  emreg_reset; // @[Ctrl.scala 52:22]
  wire [2:0] emreg_d; // @[Ctrl.scala 52:22]
  wire [2:0] emreg_q; // @[Ctrl.scala 52:22]
  wire  mwreg_clock; // @[Ctrl.scala 58:22]
  wire  mwreg_reset; // @[Ctrl.scala 58:22]
  wire [1:0] mwreg_d; // @[Ctrl.scala 58:22]
  wire [1:0] mwreg_q; // @[Ctrl.scala 58:22]
  wire [4:0] dereg_d_lo = {md_alusrc,md_regdst,ad_alucontrol}; // @[Cat.scala 31:58]
  wire [2:0] dereg_d_hi = {md_memtoreg,md_memwrite,md_regwrite}; // @[Cat.scala 31:58]
  wire  memwriteE = dereg_q[6]; // @[Ctrl.scala 47:24]
  wire [1:0] emreg_d_hi = {memtoregE,memwriteE}; // @[Cat.scala 31:58]
  Maindec md ( // @[Ctrl.scala 28:19]
    .op(md_op),
    .memtoreg(md_memtoreg),
    .memwrite(md_memwrite),
    .branch(md_branch),
    .alusrc(md_alusrc),
    .regdst(md_regdst),
    .regwrite(md_regwrite),
    .jump(md_jump),
    .aluop(md_aluop)
  );
  Aludec ad ( // @[Ctrl.scala 38:19]
    .funct(ad_funct),
    .aluop(ad_aluop),
    .alucontrol(ad_alucontrol)
  );
  Floprc dereg ( // @[Ctrl.scala 42:22]
    .clock(dereg_clock),
    .reset(dereg_reset),
    .flush(dereg_flush),
    .d(dereg_d),
    .q(dereg_q)
  );
  Flopr emreg ( // @[Ctrl.scala 52:22]
    .clock(emreg_clock),
    .reset(emreg_reset),
    .d(emreg_d),
    .q(emreg_q)
  );
  Flopr_1 mwreg ( // @[Ctrl.scala 58:22]
    .clock(mwreg_clock),
    .reset(mwreg_reset),
    .d(mwreg_d),
    .q(mwreg_q)
  );
  assign memtoregE = dereg_q[7]; // @[Ctrl.scala 46:21]
  assign memtoregM = emreg_q[2]; // @[Ctrl.scala 55:21]
  assign memtoregW = mwreg_q[1]; // @[Ctrl.scala 61:21]
  assign memwriteM = emreg_q[1]; // @[Ctrl.scala 56:21]
  assign branch = md_branch; // @[Ctrl.scala 33:10]
  assign pcsrc = branch & zero; // @[Ctrl.scala 27:19]
  assign alusrc = dereg_q[4]; // @[Ctrl.scala 49:18]
  assign regdstE = dereg_q[3]; // @[Ctrl.scala 50:19]
  assign regwriteE = dereg_q[5]; // @[Ctrl.scala 48:21]
  assign regwriteM = emreg_q[0]; // @[Ctrl.scala 57:21]
  assign regwriteW = mwreg_q[0]; // @[Ctrl.scala 62:21]
  assign jump = md_jump; // @[Ctrl.scala 37:8]
  assign alucontrol = dereg_q[2:0]; // @[Ctrl.scala 51:22]
  assign md_op = op; // @[Ctrl.scala 29:9]
  assign ad_funct = funct; // @[Ctrl.scala 39:12]
  assign ad_aluop = md_aluop; // @[Ctrl.scala 40:12]
  assign dereg_clock = clock;
  assign dereg_reset = reset;
  assign dereg_flush = flushE; // @[Ctrl.scala 43:15]
  assign dereg_d = {dereg_d_hi,dereg_d_lo}; // @[Cat.scala 31:58]
  assign emreg_clock = clock;
  assign emreg_reset = reset;
  assign emreg_d = {emreg_d_hi,regwriteE}; // @[Cat.scala 31:58]
  assign mwreg_clock = clock;
  assign mwreg_reset = reset;
  assign mwreg_d = {memtoregM,regwriteM}; // @[Cat.scala 31:58]
endmodule
module Fu_id(
  input        regwrite,
  input  [4:0] writereg,
  input  [4:0] rsD,
  input  [4:0] rtD,
  output       forwardAD,
  output       forwardBD
);
  assign forwardAD = rsD != 5'h0 & rsD == writereg & regwrite; // @[Fu_id.scala 15:47]
  assign forwardBD = rtD != 5'h0 & rtD == writereg & regwrite; // @[Fu_id.scala 16:47]
endmodule
module Fu_ex(
  input        regwriteW,
  input        regwriteM,
  input  [4:0] writeregW,
  input  [4:0] writeregM,
  input  [4:0] rsE,
  input  [4:0] rtE,
  output [1:0] forwardAE,
  output [1:0] forwardBE
);
  wire  _forwardAE_T_7 = regwriteW & rsE != 5'h0 & writeregW == rsE; // @[Fu_ex.scala 19:114]
  wire  _forwardBE_T_7 = regwriteW & rtE != 5'h0 & writeregW == rtE; // @[Fu_ex.scala 20:114]
  assign forwardAE = regwriteM & rsE != 5'h0 & writeregM == rsE ? 2'h2 : {{1'd0}, _forwardAE_T_7}; // @[Fu_ex.scala 19:19]
  assign forwardBE = regwriteM & rtE != 5'h0 & writeregM == rtE ? 2'h2 : {{1'd0}, _forwardBE_T_7}; // @[Fu_ex.scala 20:19]
endmodule
module Hazard(
  input        regwriteE,
  input        regwriteM,
  input        regwriteW,
  input  [4:0] rsE,
  input  [4:0] rtE,
  input  [4:0] rsD,
  input  [4:0] rtD,
  input  [4:0] writeregE,
  input  [4:0] writeregM,
  input  [4:0] writeregW,
  input        memtoregE,
  input        memtoregM,
  input        branchD,
  output       forwardAD,
  output       forwardBD,
  output       forwardADW,
  output       forwardBDW,
  output [1:0] forwardAE,
  output [1:0] forwardBE,
  output       flushE,
  output       stallD,
  output       stallF
);
  wire  fud_regwrite; // @[Hazard.scala 33:20]
  wire [4:0] fud_writereg; // @[Hazard.scala 33:20]
  wire [4:0] fud_rsD; // @[Hazard.scala 33:20]
  wire [4:0] fud_rtD; // @[Hazard.scala 33:20]
  wire  fud_forwardAD; // @[Hazard.scala 33:20]
  wire  fud_forwardBD; // @[Hazard.scala 33:20]
  wire  fudW_regwrite; // @[Hazard.scala 40:21]
  wire [4:0] fudW_writereg; // @[Hazard.scala 40:21]
  wire [4:0] fudW_rsD; // @[Hazard.scala 40:21]
  wire [4:0] fudW_rtD; // @[Hazard.scala 40:21]
  wire  fudW_forwardAD; // @[Hazard.scala 40:21]
  wire  fudW_forwardBD; // @[Hazard.scala 40:21]
  wire  ex_regwriteW; // @[Hazard.scala 47:19]
  wire  ex_regwriteM; // @[Hazard.scala 47:19]
  wire [4:0] ex_writeregW; // @[Hazard.scala 47:19]
  wire [4:0] ex_writeregM; // @[Hazard.scala 47:19]
  wire [4:0] ex_rsE; // @[Hazard.scala 47:19]
  wire [4:0] ex_rtE; // @[Hazard.scala 47:19]
  wire [1:0] ex_forwardAE; // @[Hazard.scala 47:19]
  wire [1:0] ex_forwardBE; // @[Hazard.scala 47:19]
  wire  lwstallD = memtoregE & (rsD == rtE | rtD == rtE); // @[Hazard.scala 57:28]
  wire  branchstallD = branchD & (regwriteE & (writeregE == rsD | writeregE == rtD) | memtoregM & (writeregM == rsD |
    writeregM == rtD)); // @[Hazard.scala 58:30]
  Fu_id fud ( // @[Hazard.scala 33:20]
    .regwrite(fud_regwrite),
    .writereg(fud_writereg),
    .rsD(fud_rsD),
    .rtD(fud_rtD),
    .forwardAD(fud_forwardAD),
    .forwardBD(fud_forwardBD)
  );
  Fu_id fudW ( // @[Hazard.scala 40:21]
    .regwrite(fudW_regwrite),
    .writereg(fudW_writereg),
    .rsD(fudW_rsD),
    .rtD(fudW_rtD),
    .forwardAD(fudW_forwardAD),
    .forwardBD(fudW_forwardBD)
  );
  Fu_ex ex ( // @[Hazard.scala 47:19]
    .regwriteW(ex_regwriteW),
    .regwriteM(ex_regwriteM),
    .writeregW(ex_writeregW),
    .writeregM(ex_writeregM),
    .rsE(ex_rsE),
    .rtE(ex_rtE),
    .forwardAE(ex_forwardAE),
    .forwardBE(ex_forwardBE)
  );
  assign forwardAD = fud_forwardAD; // @[Hazard.scala 38:13]
  assign forwardBD = fud_forwardBD; // @[Hazard.scala 39:13]
  assign forwardADW = fudW_forwardAD; // @[Hazard.scala 45:14]
  assign forwardBDW = fudW_forwardBD; // @[Hazard.scala 46:14]
  assign forwardAE = ex_forwardAE; // @[Hazard.scala 54:13]
  assign forwardBE = ex_forwardBE; // @[Hazard.scala 55:13]
  assign flushE = stallF; // @[Hazard.scala 61:10]
  assign stallD = lwstallD | branchstallD; // @[Hazard.scala 59:22]
  assign stallF = stallD; // @[Hazard.scala 60:10]
  assign fud_regwrite = regwriteM; // @[Hazard.scala 34:16]
  assign fud_writereg = writeregM; // @[Hazard.scala 37:16]
  assign fud_rsD = rsD; // @[Hazard.scala 35:11]
  assign fud_rtD = rtD; // @[Hazard.scala 36:11]
  assign fudW_regwrite = regwriteW; // @[Hazard.scala 41:17]
  assign fudW_writereg = writeregW; // @[Hazard.scala 44:17]
  assign fudW_rsD = rsD; // @[Hazard.scala 42:12]
  assign fudW_rtD = rtD; // @[Hazard.scala 43:12]
  assign ex_regwriteW = regwriteW; // @[Hazard.scala 48:16]
  assign ex_regwriteM = regwriteM; // @[Hazard.scala 49:16]
  assign ex_writeregW = writeregW; // @[Hazard.scala 50:16]
  assign ex_writeregM = writeregM; // @[Hazard.scala 51:16]
  assign ex_rsE = rsE; // @[Hazard.scala 52:10]
  assign ex_rtE = rtE; // @[Hazard.scala 53:10]
endmodule
module Mux2(
  input         s,
  input  [31:0] d0,
  input  [31:0] d1,
  output [31:0] y
);
  assign y = s ? d1 : d0; // @[Mux2.scala 12:11]
endmodule
module Regfile(
  input         clock,
  input         reset,
  input         we3,
  input  [4:0]  ra1,
  input  [4:0]  ra2,
  input  [4:0]  wa3,
  input  [31:0] wd3,
  output [31:0] rd1,
  output [31:0] rd2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] RF_0; // @[Regfile.scala 15:19]
  reg [31:0] RF_1; // @[Regfile.scala 15:19]
  reg [31:0] RF_2; // @[Regfile.scala 15:19]
  reg [31:0] RF_3; // @[Regfile.scala 15:19]
  reg [31:0] RF_4; // @[Regfile.scala 15:19]
  reg [31:0] RF_5; // @[Regfile.scala 15:19]
  reg [31:0] RF_6; // @[Regfile.scala 15:19]
  reg [31:0] RF_7; // @[Regfile.scala 15:19]
  reg [31:0] RF_8; // @[Regfile.scala 15:19]
  reg [31:0] RF_9; // @[Regfile.scala 15:19]
  reg [31:0] RF_10; // @[Regfile.scala 15:19]
  reg [31:0] RF_11; // @[Regfile.scala 15:19]
  reg [31:0] RF_12; // @[Regfile.scala 15:19]
  reg [31:0] RF_13; // @[Regfile.scala 15:19]
  reg [31:0] RF_14; // @[Regfile.scala 15:19]
  reg [31:0] RF_15; // @[Regfile.scala 15:19]
  reg [31:0] RF_16; // @[Regfile.scala 15:19]
  reg [31:0] RF_17; // @[Regfile.scala 15:19]
  reg [31:0] RF_18; // @[Regfile.scala 15:19]
  reg [31:0] RF_19; // @[Regfile.scala 15:19]
  reg [31:0] RF_20; // @[Regfile.scala 15:19]
  reg [31:0] RF_21; // @[Regfile.scala 15:19]
  reg [31:0] RF_22; // @[Regfile.scala 15:19]
  reg [31:0] RF_23; // @[Regfile.scala 15:19]
  reg [31:0] RF_24; // @[Regfile.scala 15:19]
  reg [31:0] RF_25; // @[Regfile.scala 15:19]
  reg [31:0] RF_26; // @[Regfile.scala 15:19]
  reg [31:0] RF_27; // @[Regfile.scala 15:19]
  reg [31:0] RF_28; // @[Regfile.scala 15:19]
  reg [31:0] RF_29; // @[Regfile.scala 15:19]
  reg [31:0] RF_30; // @[Regfile.scala 15:19]
  reg [31:0] RF_31; // @[Regfile.scala 15:19]
  wire [31:0] _GEN_1 = 5'h1 == ra1 ? RF_1 : RF_0; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_2 = 5'h2 == ra1 ? RF_2 : _GEN_1; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_3 = 5'h3 == ra1 ? RF_3 : _GEN_2; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_4 = 5'h4 == ra1 ? RF_4 : _GEN_3; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_5 = 5'h5 == ra1 ? RF_5 : _GEN_4; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_6 = 5'h6 == ra1 ? RF_6 : _GEN_5; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_7 = 5'h7 == ra1 ? RF_7 : _GEN_6; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_8 = 5'h8 == ra1 ? RF_8 : _GEN_7; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_9 = 5'h9 == ra1 ? RF_9 : _GEN_8; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_10 = 5'ha == ra1 ? RF_10 : _GEN_9; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_11 = 5'hb == ra1 ? RF_11 : _GEN_10; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_12 = 5'hc == ra1 ? RF_12 : _GEN_11; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_13 = 5'hd == ra1 ? RF_13 : _GEN_12; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_14 = 5'he == ra1 ? RF_14 : _GEN_13; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_15 = 5'hf == ra1 ? RF_15 : _GEN_14; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_16 = 5'h10 == ra1 ? RF_16 : _GEN_15; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_17 = 5'h11 == ra1 ? RF_17 : _GEN_16; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_18 = 5'h12 == ra1 ? RF_18 : _GEN_17; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_19 = 5'h13 == ra1 ? RF_19 : _GEN_18; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_20 = 5'h14 == ra1 ? RF_20 : _GEN_19; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_21 = 5'h15 == ra1 ? RF_21 : _GEN_20; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_22 = 5'h16 == ra1 ? RF_22 : _GEN_21; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_23 = 5'h17 == ra1 ? RF_23 : _GEN_22; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_24 = 5'h18 == ra1 ? RF_24 : _GEN_23; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_25 = 5'h19 == ra1 ? RF_25 : _GEN_24; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_26 = 5'h1a == ra1 ? RF_26 : _GEN_25; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_27 = 5'h1b == ra1 ? RF_27 : _GEN_26; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_28 = 5'h1c == ra1 ? RF_28 : _GEN_27; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_29 = 5'h1d == ra1 ? RF_29 : _GEN_28; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_30 = 5'h1e == ra1 ? RF_30 : _GEN_29; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_31 = 5'h1f == ra1 ? RF_31 : _GEN_30; // @[Regfile.scala 16:{13,13}]
  wire [31:0] _GEN_33 = 5'h1 == ra2 ? RF_1 : RF_0; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_34 = 5'h2 == ra2 ? RF_2 : _GEN_33; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_35 = 5'h3 == ra2 ? RF_3 : _GEN_34; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_36 = 5'h4 == ra2 ? RF_4 : _GEN_35; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_37 = 5'h5 == ra2 ? RF_5 : _GEN_36; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_38 = 5'h6 == ra2 ? RF_6 : _GEN_37; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_39 = 5'h7 == ra2 ? RF_7 : _GEN_38; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_40 = 5'h8 == ra2 ? RF_8 : _GEN_39; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_41 = 5'h9 == ra2 ? RF_9 : _GEN_40; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_42 = 5'ha == ra2 ? RF_10 : _GEN_41; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_43 = 5'hb == ra2 ? RF_11 : _GEN_42; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_44 = 5'hc == ra2 ? RF_12 : _GEN_43; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_45 = 5'hd == ra2 ? RF_13 : _GEN_44; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_46 = 5'he == ra2 ? RF_14 : _GEN_45; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_47 = 5'hf == ra2 ? RF_15 : _GEN_46; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_48 = 5'h10 == ra2 ? RF_16 : _GEN_47; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_49 = 5'h11 == ra2 ? RF_17 : _GEN_48; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_50 = 5'h12 == ra2 ? RF_18 : _GEN_49; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_51 = 5'h13 == ra2 ? RF_19 : _GEN_50; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_52 = 5'h14 == ra2 ? RF_20 : _GEN_51; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_53 = 5'h15 == ra2 ? RF_21 : _GEN_52; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_54 = 5'h16 == ra2 ? RF_22 : _GEN_53; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_55 = 5'h17 == ra2 ? RF_23 : _GEN_54; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_56 = 5'h18 == ra2 ? RF_24 : _GEN_55; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_57 = 5'h19 == ra2 ? RF_25 : _GEN_56; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_58 = 5'h1a == ra2 ? RF_26 : _GEN_57; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_59 = 5'h1b == ra2 ? RF_27 : _GEN_58; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_60 = 5'h1c == ra2 ? RF_28 : _GEN_59; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_61 = 5'h1d == ra2 ? RF_29 : _GEN_60; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_62 = 5'h1e == ra2 ? RF_30 : _GEN_61; // @[Regfile.scala 17:{13,13}]
  wire [31:0] _GEN_63 = 5'h1f == ra2 ? RF_31 : _GEN_62; // @[Regfile.scala 17:{13,13}]
  assign rd1 = ra1 != 5'h0 ? _GEN_31 : 32'h0; // @[Regfile.scala 16:13]
  assign rd2 = ra2 != 5'h0 ? _GEN_63 : 32'h0; // @[Regfile.scala 17:13]
  always @(posedge clock) begin
    if (reset) begin // @[Regfile.scala 15:19]
      RF_0 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h0 == wa3) begin // @[Regfile.scala 19:13]
        RF_0 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_1 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h1 == wa3) begin // @[Regfile.scala 19:13]
        RF_1 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_2 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h2 == wa3) begin // @[Regfile.scala 19:13]
        RF_2 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_3 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h3 == wa3) begin // @[Regfile.scala 19:13]
        RF_3 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_4 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h4 == wa3) begin // @[Regfile.scala 19:13]
        RF_4 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_5 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h5 == wa3) begin // @[Regfile.scala 19:13]
        RF_5 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_6 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h6 == wa3) begin // @[Regfile.scala 19:13]
        RF_6 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_7 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h7 == wa3) begin // @[Regfile.scala 19:13]
        RF_7 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_8 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h8 == wa3) begin // @[Regfile.scala 19:13]
        RF_8 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_9 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h9 == wa3) begin // @[Regfile.scala 19:13]
        RF_9 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_10 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'ha == wa3) begin // @[Regfile.scala 19:13]
        RF_10 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_11 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'hb == wa3) begin // @[Regfile.scala 19:13]
        RF_11 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_12 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'hc == wa3) begin // @[Regfile.scala 19:13]
        RF_12 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_13 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'hd == wa3) begin // @[Regfile.scala 19:13]
        RF_13 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_14 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'he == wa3) begin // @[Regfile.scala 19:13]
        RF_14 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_15 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'hf == wa3) begin // @[Regfile.scala 19:13]
        RF_15 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_16 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h10 == wa3) begin // @[Regfile.scala 19:13]
        RF_16 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_17 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h11 == wa3) begin // @[Regfile.scala 19:13]
        RF_17 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_18 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h12 == wa3) begin // @[Regfile.scala 19:13]
        RF_18 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_19 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h13 == wa3) begin // @[Regfile.scala 19:13]
        RF_19 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_20 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h14 == wa3) begin // @[Regfile.scala 19:13]
        RF_20 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_21 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h15 == wa3) begin // @[Regfile.scala 19:13]
        RF_21 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_22 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h16 == wa3) begin // @[Regfile.scala 19:13]
        RF_22 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_23 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h17 == wa3) begin // @[Regfile.scala 19:13]
        RF_23 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_24 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h18 == wa3) begin // @[Regfile.scala 19:13]
        RF_24 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_25 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h19 == wa3) begin // @[Regfile.scala 19:13]
        RF_25 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_26 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h1a == wa3) begin // @[Regfile.scala 19:13]
        RF_26 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_27 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h1b == wa3) begin // @[Regfile.scala 19:13]
        RF_27 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_28 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h1c == wa3) begin // @[Regfile.scala 19:13]
        RF_28 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_29 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h1d == wa3) begin // @[Regfile.scala 19:13]
        RF_29 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_30 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h1e == wa3) begin // @[Regfile.scala 19:13]
        RF_30 <= wd3; // @[Regfile.scala 19:13]
      end
    end
    if (reset) begin // @[Regfile.scala 15:19]
      RF_31 <= 32'h0; // @[Regfile.scala 15:19]
    end else if (we3) begin // @[Regfile.scala 18:12]
      if (5'h1f == wa3) begin // @[Regfile.scala 19:13]
        RF_31 <= wd3; // @[Regfile.scala 19:13]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RF_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  RF_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  RF_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  RF_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  RF_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  RF_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  RF_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  RF_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  RF_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  RF_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  RF_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  RF_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  RF_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  RF_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  RF_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  RF_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  RF_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  RF_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  RF_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  RF_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  RF_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  RF_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  RF_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  RF_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  RF_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  RF_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  RF_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  RF_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  RF_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  RF_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  RF_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  RF_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Flopenr(
  input         clock,
  input         reset,
  input         en,
  input  [31:0] d,
  output [31:0] q
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_; // @[Reg.scala 28:20]
  assign q = reg_; // @[Flopenr.scala 12:5]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 28:20]
      reg_ <= 32'h0; // @[Reg.scala 28:20]
    end else if (en) begin // @[Reg.scala 29:18]
      reg_ <= d; // @[Reg.scala 29:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Adder(
  input  [31:0] a,
  input  [31:0] b,
  output [31:0] y
);
  assign y = a + b; // @[Adder.scala 11:10]
endmodule
module Flopenrc(
  input         clock,
  input         reset,
  input         en,
  input         flush,
  input  [31:0] d,
  input  [31:0] old_q,
  output [31:0] q
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_REG; // @[Flopenrc.scala 16:15]
  assign q = q_REG; // @[Flopenrc.scala 16:5]
  always @(posedge clock) begin
    if (reset) begin // @[Flopenrc.scala 16:15]
      q_REG <= 32'h0; // @[Flopenrc.scala 16:15]
    end else if (flush) begin // @[Flopenrc.scala 15:17]
      q_REG <= 32'h0;
    end else if (en) begin // @[Flopenrc.scala 14:16]
      q_REG <= d;
    end else begin
      q_REG <= old_q;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_REG = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Signnext(
  input  [15:0] a,
  output [31:0] y
);
  wire [15:0] _y_T_2 = a[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 74:12]
  assign y = {_y_T_2,a}; // @[Cat.scala 31:58]
endmodule
module Sl2(
  input  [31:0] a,
  output [31:0] y
);
  wire [33:0] _y_T = {a, 2'h0}; // @[Sl2.scala 10:10]
  assign y = _y_T[31:0]; // @[Sl2.scala 10:5]
endmodule
module Comparator(
  input  [31:0] a,
  input  [31:0] b,
  output        e
);
  assign e = a == b; // @[Comparator.scala 11:11]
endmodule
module Floprc_1(
  input         clock,
  input         reset,
  input         flush,
  input  [31:0] d,
  output [31:0] q
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_REG; // @[Floprc.scala 12:15]
  assign q = q_REG; // @[Floprc.scala 12:5]
  always @(posedge clock) begin
    if (reset) begin // @[Floprc.scala 12:15]
      q_REG <= 32'h0; // @[Floprc.scala 12:15]
    end else if (flush) begin // @[Floprc.scala 11:17]
      q_REG <= 32'h0;
    end else begin
      q_REG <= d;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_REG = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Floprc_4(
  input        clock,
  input        reset,
  input        flush,
  input  [4:0] d,
  output [4:0] q
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] q_REG; // @[Floprc.scala 12:15]
  assign q = q_REG; // @[Floprc.scala 12:5]
  always @(posedge clock) begin
    if (reset) begin // @[Floprc.scala 12:15]
      q_REG <= 5'h0; // @[Floprc.scala 12:15]
    end else if (flush) begin // @[Floprc.scala 11:17]
      q_REG <= 5'h0;
    end else begin
      q_REG <= d;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_REG = _RAND_0[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Id_e(
  input         clock,
  input         reset,
  input         flush,
  input  [31:0] readdata1D,
  input  [31:0] readdata2D,
  input  [31:0] signD,
  input  [4:0]  rsD,
  input  [4:0]  rtD,
  input  [4:0]  rdD,
  output [31:0] readdata1E,
  output [31:0] readdata2E,
  output [31:0] signE,
  output [4:0]  rsE,
  output [4:0]  rtE,
  output [4:0]  rdE
);
  wire  f1_clock; // @[Id_e.scala 25:18]
  wire  f1_reset; // @[Id_e.scala 25:18]
  wire  f1_flush; // @[Id_e.scala 25:18]
  wire [31:0] f1_d; // @[Id_e.scala 25:18]
  wire [31:0] f1_q; // @[Id_e.scala 25:18]
  wire  f2_clock; // @[Id_e.scala 33:18]
  wire  f2_reset; // @[Id_e.scala 33:18]
  wire  f2_flush; // @[Id_e.scala 33:18]
  wire [31:0] f2_d; // @[Id_e.scala 33:18]
  wire [31:0] f2_q; // @[Id_e.scala 33:18]
  wire  fsign_clock; // @[Id_e.scala 41:21]
  wire  fsign_reset; // @[Id_e.scala 41:21]
  wire  fsign_flush; // @[Id_e.scala 41:21]
  wire [31:0] fsign_d; // @[Id_e.scala 41:21]
  wire [31:0] fsign_q; // @[Id_e.scala 41:21]
  wire  frs_clock; // @[Id_e.scala 49:19]
  wire  frs_reset; // @[Id_e.scala 49:19]
  wire  frs_flush; // @[Id_e.scala 49:19]
  wire [4:0] frs_d; // @[Id_e.scala 49:19]
  wire [4:0] frs_q; // @[Id_e.scala 49:19]
  wire  frt_clock; // @[Id_e.scala 57:19]
  wire  frt_reset; // @[Id_e.scala 57:19]
  wire  frt_flush; // @[Id_e.scala 57:19]
  wire [4:0] frt_d; // @[Id_e.scala 57:19]
  wire [4:0] frt_q; // @[Id_e.scala 57:19]
  wire  frd_clock; // @[Id_e.scala 65:19]
  wire  frd_reset; // @[Id_e.scala 65:19]
  wire  frd_flush; // @[Id_e.scala 65:19]
  wire [4:0] frd_d; // @[Id_e.scala 65:19]
  wire [4:0] frd_q; // @[Id_e.scala 65:19]
  Floprc_1 f1 ( // @[Id_e.scala 25:18]
    .clock(f1_clock),
    .reset(f1_reset),
    .flush(f1_flush),
    .d(f1_d),
    .q(f1_q)
  );
  Floprc_1 f2 ( // @[Id_e.scala 33:18]
    .clock(f2_clock),
    .reset(f2_reset),
    .flush(f2_flush),
    .d(f2_d),
    .q(f2_q)
  );
  Floprc_1 fsign ( // @[Id_e.scala 41:21]
    .clock(fsign_clock),
    .reset(fsign_reset),
    .flush(fsign_flush),
    .d(fsign_d),
    .q(fsign_q)
  );
  Floprc_4 frs ( // @[Id_e.scala 49:19]
    .clock(frs_clock),
    .reset(frs_reset),
    .flush(frs_flush),
    .d(frs_d),
    .q(frs_q)
  );
  Floprc_4 frt ( // @[Id_e.scala 57:19]
    .clock(frt_clock),
    .reset(frt_reset),
    .flush(frt_flush),
    .d(frt_d),
    .q(frt_q)
  );
  Floprc_4 frd ( // @[Id_e.scala 65:19]
    .clock(frd_clock),
    .reset(frd_reset),
    .flush(frd_flush),
    .d(frd_d),
    .q(frd_q)
  );
  assign readdata1E = f1_q; // @[Id_e.scala 28:14]
  assign readdata2E = f2_q; // @[Id_e.scala 36:14]
  assign signE = fsign_q; // @[Id_e.scala 44:9]
  assign rsE = frs_q; // @[Id_e.scala 52:7]
  assign rtE = frt_q; // @[Id_e.scala 60:7]
  assign rdE = frd_q; // @[Id_e.scala 68:7]
  assign f1_clock = clock;
  assign f1_reset = reset;
  assign f1_flush = flush; // @[Id_e.scala 26:12]
  assign f1_d = readdata1D; // @[Id_e.scala 27:8]
  assign f2_clock = clock;
  assign f2_reset = reset;
  assign f2_flush = flush; // @[Id_e.scala 34:12]
  assign f2_d = readdata2D; // @[Id_e.scala 35:8]
  assign fsign_clock = clock;
  assign fsign_reset = reset;
  assign fsign_flush = flush; // @[Id_e.scala 42:15]
  assign fsign_d = signD; // @[Id_e.scala 43:11]
  assign frs_clock = clock;
  assign frs_reset = reset;
  assign frs_flush = flush; // @[Id_e.scala 50:13]
  assign frs_d = rsD; // @[Id_e.scala 51:9]
  assign frt_clock = clock;
  assign frt_reset = reset;
  assign frt_flush = flush; // @[Id_e.scala 58:13]
  assign frt_d = rtD; // @[Id_e.scala 59:9]
  assign frd_clock = clock;
  assign frd_reset = reset;
  assign frd_flush = flush; // @[Id_e.scala 66:13]
  assign frd_d = rdD; // @[Id_e.scala 67:9]
endmodule
module Mux3(
  input  [31:0] rd,
  input  [31:0] resultW,
  input  [31:0] alusrcM,
  input  [1:0]  forward,
  output [31:0] muxresult
);
  wire [31:0] _muxresult_T_2 = forward == 2'h1 ? resultW : rd; // @[Mux3.scala 13:51]
  assign muxresult = forward == 2'h2 ? alusrcM : _muxresult_T_2; // @[Mux3.scala 13:19]
endmodule
module Mux2_5(
  input        s,
  input  [4:0] d0,
  input  [4:0] d1,
  output [4:0] y
);
  assign y = s ? d1 : d0; // @[Mux2.scala 12:11]
endmodule
module Alu_p(
  input  [31:0] a,
  input  [31:0] b,
  input  [2:0]  alucontrol,
  output [31:0] aluout
);
  wire [31:0] _bb_T_1 = ~b; // @[Alu_p.scala 12:30]
  wire [31:0] bb = alucontrol[2] ? _bb_T_1 : b; // @[Alu_p.scala 12:15]
  wire [31:0] _s_T_1 = a + bb; // @[Alu_p.scala 13:13]
  wire [31:0] _GEN_4 = {{31'd0}, alucontrol[2]}; // @[Alu_p.scala 13:18]
  wire [31:0] s = _s_T_1 + _GEN_4; // @[Alu_p.scala 13:18]
  wire  _T_1 = ~alucontrol[1]; // @[Alu_p.scala 15:22]
  wire  _T_3 = ~alucontrol[0]; // @[Alu_p.scala 15:46]
  wire [31:0] _aluout_T = a & bb; // @[Alu_p.scala 15:67]
  wire [31:0] _aluout_T_1 = a | bb; // @[Alu_p.scala 16:72]
  wire  _GEN_0 = alucontrol[1] & alucontrol[0] & s[31]; // @[Alu_p.scala 18:{59,67} 19:21]
  wire [31:0] _GEN_1 = alucontrol[1] & _T_3 ? s : {{31'd0}, _GEN_0}; // @[Alu_p.scala 17:{59,67}]
  wire [31:0] _GEN_2 = _T_1 & alucontrol[0] ? _aluout_T_1 : _GEN_1; // @[Alu_p.scala 16:{59,67}]
  assign aluout = ~alucontrol[1] & ~alucontrol[0] ? _aluout_T : _GEN_2; // @[Alu_p.scala 15:{54,62}]
endmodule
module Execute(
  input  [31:0] aluoutM,
  input  [31:0] resultW,
  input  [31:0] rd1E,
  input  [31:0] rd2E,
  input  [31:0] signE,
  input         alusrcE,
  input         regdst,
  input  [4:0]  rdE,
  input  [4:0]  rtE,
  input  [1:0]  forwardaE,
  input  [1:0]  forwardbE,
  input  [2:0]  alucontrolE,
  output [4:0]  writeregE,
  output [31:0] writedataE,
  output [31:0] aluoutE
);
  wire [31:0] mux3A_rd; // @[Execute.scala 26:22]
  wire [31:0] mux3A_resultW; // @[Execute.scala 26:22]
  wire [31:0] mux3A_alusrcM; // @[Execute.scala 26:22]
  wire [1:0] mux3A_forward; // @[Execute.scala 26:22]
  wire [31:0] mux3A_muxresult; // @[Execute.scala 26:22]
  wire [31:0] mux3B_rd; // @[Execute.scala 33:22]
  wire [31:0] mux3B_resultW; // @[Execute.scala 33:22]
  wire [31:0] mux3B_alusrcM; // @[Execute.scala 33:22]
  wire [1:0] mux3B_forward; // @[Execute.scala 33:22]
  wire [31:0] mux3B_muxresult; // @[Execute.scala 33:22]
  wire  mux2A_s; // @[Execute.scala 40:22]
  wire [4:0] mux2A_d0; // @[Execute.scala 40:22]
  wire [4:0] mux2A_d1; // @[Execute.scala 40:22]
  wire [4:0] mux2A_y; // @[Execute.scala 40:22]
  wire  mux2B_s; // @[Execute.scala 46:22]
  wire [31:0] mux2B_d0; // @[Execute.scala 46:22]
  wire [31:0] mux2B_d1; // @[Execute.scala 46:22]
  wire [31:0] mux2B_y; // @[Execute.scala 46:22]
  wire [31:0] alu_a; // @[Execute.scala 52:20]
  wire [31:0] alu_b; // @[Execute.scala 52:20]
  wire [2:0] alu_alucontrol; // @[Execute.scala 52:20]
  wire [31:0] alu_aluout; // @[Execute.scala 52:20]
  Mux3 mux3A ( // @[Execute.scala 26:22]
    .rd(mux3A_rd),
    .resultW(mux3A_resultW),
    .alusrcM(mux3A_alusrcM),
    .forward(mux3A_forward),
    .muxresult(mux3A_muxresult)
  );
  Mux3 mux3B ( // @[Execute.scala 33:22]
    .rd(mux3B_rd),
    .resultW(mux3B_resultW),
    .alusrcM(mux3B_alusrcM),
    .forward(mux3B_forward),
    .muxresult(mux3B_muxresult)
  );
  Mux2_5 mux2A ( // @[Execute.scala 40:22]
    .s(mux2A_s),
    .d0(mux2A_d0),
    .d1(mux2A_d1),
    .y(mux2A_y)
  );
  Mux2 mux2B ( // @[Execute.scala 46:22]
    .s(mux2B_s),
    .d0(mux2B_d0),
    .d1(mux2B_d1),
    .y(mux2B_y)
  );
  Alu_p alu ( // @[Execute.scala 52:20]
    .a(alu_a),
    .b(alu_b),
    .alucontrol(alu_alucontrol),
    .aluout(alu_aluout)
  );
  assign writeregE = mux2A_y; // @[Execute.scala 44:13]
  assign writedataE = mux3B_muxresult; // @[Execute.scala 58:14]
  assign aluoutE = alu_aluout; // @[Execute.scala 56:11]
  assign mux3A_rd = rd1E; // @[Execute.scala 27:12]
  assign mux3A_resultW = resultW; // @[Execute.scala 28:17]
  assign mux3A_alusrcM = aluoutM; // @[Execute.scala 29:17]
  assign mux3A_forward = forwardaE; // @[Execute.scala 30:17]
  assign mux3B_rd = rd2E; // @[Execute.scala 34:12]
  assign mux3B_resultW = resultW; // @[Execute.scala 35:17]
  assign mux3B_alusrcM = aluoutM; // @[Execute.scala 36:17]
  assign mux3B_forward = forwardbE; // @[Execute.scala 37:17]
  assign mux2A_s = regdst; // @[Execute.scala 41:11]
  assign mux2A_d0 = rtE; // @[Execute.scala 42:12]
  assign mux2A_d1 = rdE; // @[Execute.scala 43:12]
  assign mux2B_s = alusrcE; // @[Execute.scala 47:11]
  assign mux2B_d0 = mux3B_muxresult; // @[Execute.scala 48:12]
  assign mux2B_d1 = signE; // @[Execute.scala 49:12]
  assign alu_a = mux3A_muxresult; // @[Execute.scala 53:9]
  assign alu_b = mux2B_y; // @[Execute.scala 54:9]
  assign alu_alucontrol = alucontrolE; // @[Execute.scala 55:18]
endmodule
module E_m(
  input         clock,
  input  [4:0]  writeregE,
  input  [31:0] aluoutE,
  input  [31:0] writedataE,
  output [4:0]  writeregM,
  output [31:0] aluoutM,
  output [31:0] writedataM
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] reg1; // @[E_m.scala 14:17]
  reg [31:0] reg2; // @[E_m.scala 17:17]
  reg [31:0] reg3; // @[E_m.scala 20:17]
  assign writeregM = reg1; // @[E_m.scala 16:13]
  assign aluoutM = reg2; // @[E_m.scala 19:11]
  assign writedataM = reg3; // @[E_m.scala 22:14]
  always @(posedge clock) begin
    reg1 <= writeregE; // @[E_m.scala 15:8]
    reg2 <= aluoutE; // @[E_m.scala 18:8]
    reg3 <= writedataE; // @[E_m.scala 21:8]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg1 = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  reg2 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg3 = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Datapath(
  input         clock,
  input         reset,
  input         memtoregE,
  input         memtoregM,
  input         memtoregW,
  input         branch,
  input         pcsrc,
  input         alusrc,
  input         regdstE,
  input         regwriteE,
  input         regwriteM,
  input         regwriteW,
  input         jump,
  input  [2:0]  alucontrol,
  input  [31:0] instr,
  input  [31:0] readdataM,
  output        zero,
  output [31:0] pc,
  output [31:0] aluout,
  output [31:0] writedataM,
  output [5:0]  op,
  output [5:0]  funct,
  output        flushE
);
  wire  ha_regwriteE; // @[Datapath.scala 34:19]
  wire  ha_regwriteM; // @[Datapath.scala 34:19]
  wire  ha_regwriteW; // @[Datapath.scala 34:19]
  wire [4:0] ha_rsE; // @[Datapath.scala 34:19]
  wire [4:0] ha_rtE; // @[Datapath.scala 34:19]
  wire [4:0] ha_rsD; // @[Datapath.scala 34:19]
  wire [4:0] ha_rtD; // @[Datapath.scala 34:19]
  wire [4:0] ha_writeregE; // @[Datapath.scala 34:19]
  wire [4:0] ha_writeregM; // @[Datapath.scala 34:19]
  wire [4:0] ha_writeregW; // @[Datapath.scala 34:19]
  wire  ha_memtoregE; // @[Datapath.scala 34:19]
  wire  ha_memtoregM; // @[Datapath.scala 34:19]
  wire  ha_branchD; // @[Datapath.scala 34:19]
  wire  ha_forwardAD; // @[Datapath.scala 34:19]
  wire  ha_forwardBD; // @[Datapath.scala 34:19]
  wire  ha_forwardADW; // @[Datapath.scala 34:19]
  wire  ha_forwardBDW; // @[Datapath.scala 34:19]
  wire [1:0] ha_forwardAE; // @[Datapath.scala 34:19]
  wire [1:0] ha_forwardBE; // @[Datapath.scala 34:19]
  wire  ha_flushE; // @[Datapath.scala 34:19]
  wire  ha_stallD; // @[Datapath.scala 34:19]
  wire  ha_stallF; // @[Datapath.scala 34:19]
  wire  pcbrmux_s; // @[Datapath.scala 45:24]
  wire [31:0] pcbrmux_d0; // @[Datapath.scala 45:24]
  wire [31:0] pcbrmux_d1; // @[Datapath.scala 45:24]
  wire [31:0] pcbrmux_y; // @[Datapath.scala 45:24]
  wire  rf_clock; // @[Datapath.scala 48:18]
  wire  rf_reset; // @[Datapath.scala 48:18]
  wire  rf_we3; // @[Datapath.scala 48:18]
  wire [4:0] rf_ra1; // @[Datapath.scala 48:18]
  wire [4:0] rf_ra2; // @[Datapath.scala 48:18]
  wire [4:0] rf_wa3; // @[Datapath.scala 48:18]
  wire [31:0] rf_wd3; // @[Datapath.scala 48:18]
  wire [31:0] rf_rd1; // @[Datapath.scala 48:18]
  wire [31:0] rf_rd2; // @[Datapath.scala 48:18]
  wire  pcreg_clock; // @[Datapath.scala 52:21]
  wire  pcreg_reset; // @[Datapath.scala 52:21]
  wire  pcreg_en; // @[Datapath.scala 52:21]
  wire [31:0] pcreg_d; // @[Datapath.scala 52:21]
  wire [31:0] pcreg_q; // @[Datapath.scala 52:21]
  wire [31:0] pcadd1_a; // @[Datapath.scala 55:22]
  wire [31:0] pcadd1_b; // @[Datapath.scala 55:22]
  wire [31:0] pcadd1_y; // @[Datapath.scala 55:22]
  wire  fdp_clock; // @[Datapath.scala 58:20]
  wire  fdp_reset; // @[Datapath.scala 58:20]
  wire  fdp_en; // @[Datapath.scala 58:20]
  wire [31:0] fdp_d; // @[Datapath.scala 58:20]
  wire [31:0] fdp_q; // @[Datapath.scala 58:20]
  wire  fdi_clock; // @[Datapath.scala 61:20]
  wire  fdi_reset; // @[Datapath.scala 61:20]
  wire  fdi_en; // @[Datapath.scala 61:20]
  wire  fdi_flush; // @[Datapath.scala 61:20]
  wire [31:0] fdi_d; // @[Datapath.scala 61:20]
  wire [31:0] fdi_old_q; // @[Datapath.scala 61:20]
  wire [31:0] fdi_q; // @[Datapath.scala 61:20]
  wire [15:0] se_a; // @[Datapath.scala 70:18]
  wire [31:0] se_y; // @[Datapath.scala 70:18]
  wire [31:0] immsh_a; // @[Datapath.scala 73:21]
  wire [31:0] immsh_y; // @[Datapath.scala 73:21]
  wire [31:0] pcadd2_a; // @[Datapath.scala 76:22]
  wire [31:0] pcadd2_b; // @[Datapath.scala 76:22]
  wire [31:0] pcadd2_y; // @[Datapath.scala 76:22]
  wire  muxADW_s; // @[Datapath.scala 79:22]
  wire [31:0] muxADW_d0; // @[Datapath.scala 79:22]
  wire [31:0] muxADW_d1; // @[Datapath.scala 79:22]
  wire [31:0] muxADW_y; // @[Datapath.scala 79:22]
  wire  muxBDW_s; // @[Datapath.scala 82:22]
  wire [31:0] muxBDW_d0; // @[Datapath.scala 82:22]
  wire [31:0] muxBDW_d1; // @[Datapath.scala 82:22]
  wire [31:0] muxBDW_y; // @[Datapath.scala 82:22]
  wire  muxAD_s; // @[Datapath.scala 85:21]
  wire [31:0] muxAD_d0; // @[Datapath.scala 85:21]
  wire [31:0] muxAD_d1; // @[Datapath.scala 85:21]
  wire [31:0] muxAD_y; // @[Datapath.scala 85:21]
  wire  muxBD_s; // @[Datapath.scala 88:21]
  wire [31:0] muxBD_d0; // @[Datapath.scala 88:21]
  wire [31:0] muxBD_d1; // @[Datapath.scala 88:21]
  wire [31:0] muxBD_y; // @[Datapath.scala 88:21]
  wire [31:0] comp_a; // @[Datapath.scala 92:20]
  wire [31:0] comp_b; // @[Datapath.scala 92:20]
  wire  comp_e; // @[Datapath.scala 92:20]
  wire  de_clock; // @[Datapath.scala 95:18]
  wire  de_reset; // @[Datapath.scala 95:18]
  wire  de_flush; // @[Datapath.scala 95:18]
  wire [31:0] de_readdata1D; // @[Datapath.scala 95:18]
  wire [31:0] de_readdata2D; // @[Datapath.scala 95:18]
  wire [31:0] de_signD; // @[Datapath.scala 95:18]
  wire [4:0] de_rsD; // @[Datapath.scala 95:18]
  wire [4:0] de_rtD; // @[Datapath.scala 95:18]
  wire [4:0] de_rdD; // @[Datapath.scala 95:18]
  wire [31:0] de_readdata1E; // @[Datapath.scala 95:18]
  wire [31:0] de_readdata2E; // @[Datapath.scala 95:18]
  wire [31:0] de_signE; // @[Datapath.scala 95:18]
  wire [4:0] de_rsE; // @[Datapath.scala 95:18]
  wire [4:0] de_rtE; // @[Datapath.scala 95:18]
  wire [4:0] de_rdE; // @[Datapath.scala 95:18]
  wire [31:0] ex_aluoutM; // @[Datapath.scala 103:18]
  wire [31:0] ex_resultW; // @[Datapath.scala 103:18]
  wire [31:0] ex_rd1E; // @[Datapath.scala 103:18]
  wire [31:0] ex_rd2E; // @[Datapath.scala 103:18]
  wire [31:0] ex_signE; // @[Datapath.scala 103:18]
  wire  ex_alusrcE; // @[Datapath.scala 103:18]
  wire  ex_regdst; // @[Datapath.scala 103:18]
  wire [4:0] ex_rdE; // @[Datapath.scala 103:18]
  wire [4:0] ex_rtE; // @[Datapath.scala 103:18]
  wire [1:0] ex_forwardaE; // @[Datapath.scala 103:18]
  wire [1:0] ex_forwardbE; // @[Datapath.scala 103:18]
  wire [2:0] ex_alucontrolE; // @[Datapath.scala 103:18]
  wire [4:0] ex_writeregE; // @[Datapath.scala 103:18]
  wire [31:0] ex_writedataE; // @[Datapath.scala 103:18]
  wire [31:0] ex_aluoutE; // @[Datapath.scala 103:18]
  wire  em_clock; // @[Datapath.scala 108:18]
  wire [4:0] em_writeregE; // @[Datapath.scala 108:18]
  wire [31:0] em_aluoutE; // @[Datapath.scala 108:18]
  wire [31:0] em_writedataE; // @[Datapath.scala 108:18]
  wire [4:0] em_writeregM; // @[Datapath.scala 108:18]
  wire [31:0] em_aluoutM; // @[Datapath.scala 108:18]
  wire [31:0] em_writedataM; // @[Datapath.scala 108:18]
  wire  mw_clock; // @[Datapath.scala 113:18]
  wire [4:0] mw_writeregE; // @[Datapath.scala 113:18]
  wire [31:0] mw_aluoutE; // @[Datapath.scala 113:18]
  wire [31:0] mw_writedataE; // @[Datapath.scala 113:18]
  wire [4:0] mw_writeregM; // @[Datapath.scala 113:18]
  wire [31:0] mw_aluoutM; // @[Datapath.scala 113:18]
  wire [31:0] mw_writedataM; // @[Datapath.scala 113:18]
  wire  wbmux_s; // @[Datapath.scala 118:21]
  wire [31:0] wbmux_d0; // @[Datapath.scala 118:21]
  wire [31:0] wbmux_d1; // @[Datapath.scala 118:21]
  wire [31:0] wbmux_y; // @[Datapath.scala 118:21]
  wire  pcmux_s; // @[Datapath.scala 121:22]
  wire [31:0] pcmux_d0; // @[Datapath.scala 121:22]
  wire [31:0] pcmux_d1; // @[Datapath.scala 121:22]
  wire [31:0] pcmux_y; // @[Datapath.scala 121:22]
  wire [29:0] pcmux_d1_hi = {fdp_q[31:28],fdi_q[25:0]}; // @[Cat.scala 31:58]
  Hazard ha ( // @[Datapath.scala 34:19]
    .regwriteE(ha_regwriteE),
    .regwriteM(ha_regwriteM),
    .regwriteW(ha_regwriteW),
    .rsE(ha_rsE),
    .rtE(ha_rtE),
    .rsD(ha_rsD),
    .rtD(ha_rtD),
    .writeregE(ha_writeregE),
    .writeregM(ha_writeregM),
    .writeregW(ha_writeregW),
    .memtoregE(ha_memtoregE),
    .memtoregM(ha_memtoregM),
    .branchD(ha_branchD),
    .forwardAD(ha_forwardAD),
    .forwardBD(ha_forwardBD),
    .forwardADW(ha_forwardADW),
    .forwardBDW(ha_forwardBDW),
    .forwardAE(ha_forwardAE),
    .forwardBE(ha_forwardBE),
    .flushE(ha_flushE),
    .stallD(ha_stallD),
    .stallF(ha_stallF)
  );
  Mux2 pcbrmux ( // @[Datapath.scala 45:24]
    .s(pcbrmux_s),
    .d0(pcbrmux_d0),
    .d1(pcbrmux_d1),
    .y(pcbrmux_y)
  );
  Regfile rf ( // @[Datapath.scala 48:18]
    .clock(rf_clock),
    .reset(rf_reset),
    .we3(rf_we3),
    .ra1(rf_ra1),
    .ra2(rf_ra2),
    .wa3(rf_wa3),
    .wd3(rf_wd3),
    .rd1(rf_rd1),
    .rd2(rf_rd2)
  );
  Flopenr pcreg ( // @[Datapath.scala 52:21]
    .clock(pcreg_clock),
    .reset(pcreg_reset),
    .en(pcreg_en),
    .d(pcreg_d),
    .q(pcreg_q)
  );
  Adder pcadd1 ( // @[Datapath.scala 55:22]
    .a(pcadd1_a),
    .b(pcadd1_b),
    .y(pcadd1_y)
  );
  Flopenr fdp ( // @[Datapath.scala 58:20]
    .clock(fdp_clock),
    .reset(fdp_reset),
    .en(fdp_en),
    .d(fdp_d),
    .q(fdp_q)
  );
  Flopenrc fdi ( // @[Datapath.scala 61:20]
    .clock(fdi_clock),
    .reset(fdi_reset),
    .en(fdi_en),
    .flush(fdi_flush),
    .d(fdi_d),
    .old_q(fdi_old_q),
    .q(fdi_q)
  );
  Signnext se ( // @[Datapath.scala 70:18]
    .a(se_a),
    .y(se_y)
  );
  Sl2 immsh ( // @[Datapath.scala 73:21]
    .a(immsh_a),
    .y(immsh_y)
  );
  Adder pcadd2 ( // @[Datapath.scala 76:22]
    .a(pcadd2_a),
    .b(pcadd2_b),
    .y(pcadd2_y)
  );
  Mux2 muxADW ( // @[Datapath.scala 79:22]
    .s(muxADW_s),
    .d0(muxADW_d0),
    .d1(muxADW_d1),
    .y(muxADW_y)
  );
  Mux2 muxBDW ( // @[Datapath.scala 82:22]
    .s(muxBDW_s),
    .d0(muxBDW_d0),
    .d1(muxBDW_d1),
    .y(muxBDW_y)
  );
  Mux2 muxAD ( // @[Datapath.scala 85:21]
    .s(muxAD_s),
    .d0(muxAD_d0),
    .d1(muxAD_d1),
    .y(muxAD_y)
  );
  Mux2 muxBD ( // @[Datapath.scala 88:21]
    .s(muxBD_s),
    .d0(muxBD_d0),
    .d1(muxBD_d1),
    .y(muxBD_y)
  );
  Comparator comp ( // @[Datapath.scala 92:20]
    .a(comp_a),
    .b(comp_b),
    .e(comp_e)
  );
  Id_e de ( // @[Datapath.scala 95:18]
    .clock(de_clock),
    .reset(de_reset),
    .flush(de_flush),
    .readdata1D(de_readdata1D),
    .readdata2D(de_readdata2D),
    .signD(de_signD),
    .rsD(de_rsD),
    .rtD(de_rtD),
    .rdD(de_rdD),
    .readdata1E(de_readdata1E),
    .readdata2E(de_readdata2E),
    .signE(de_signE),
    .rsE(de_rsE),
    .rtE(de_rtE),
    .rdE(de_rdE)
  );
  Execute ex ( // @[Datapath.scala 103:18]
    .aluoutM(ex_aluoutM),
    .resultW(ex_resultW),
    .rd1E(ex_rd1E),
    .rd2E(ex_rd2E),
    .signE(ex_signE),
    .alusrcE(ex_alusrcE),
    .regdst(ex_regdst),
    .rdE(ex_rdE),
    .rtE(ex_rtE),
    .forwardaE(ex_forwardaE),
    .forwardbE(ex_forwardbE),
    .alucontrolE(ex_alucontrolE),
    .writeregE(ex_writeregE),
    .writedataE(ex_writedataE),
    .aluoutE(ex_aluoutE)
  );
  E_m em ( // @[Datapath.scala 108:18]
    .clock(em_clock),
    .writeregE(em_writeregE),
    .aluoutE(em_aluoutE),
    .writedataE(em_writedataE),
    .writeregM(em_writeregM),
    .aluoutM(em_aluoutM),
    .writedataM(em_writedataM)
  );
  E_m mw ( // @[Datapath.scala 113:18]
    .clock(mw_clock),
    .writeregE(mw_writeregE),
    .aluoutE(mw_aluoutE),
    .writedataE(mw_writedataE),
    .writeregM(mw_writeregM),
    .aluoutM(mw_aluoutM),
    .writedataM(mw_writedataM)
  );
  Mux2 wbmux ( // @[Datapath.scala 118:21]
    .s(wbmux_s),
    .d0(wbmux_d0),
    .d1(wbmux_d1),
    .y(wbmux_y)
  );
  Mux2 pcmux ( // @[Datapath.scala 121:22]
    .s(pcmux_s),
    .d0(pcmux_d0),
    .d1(pcmux_d1),
    .y(pcmux_y)
  );
  assign zero = comp_e; // @[Datapath.scala 93:8]
  assign pc = pcreg_q; // @[Datapath.scala 53:6]
  assign aluout = em_aluoutM; // @[Datapath.scala 110:10]
  assign writedataM = em_writedataM; // @[Datapath.scala 111:14]
  assign op = fdi_q[31:26]; // @[Datapath.scala 64:15]
  assign funct = fdi_q[5:0]; // @[Datapath.scala 65:18]
  assign flushE = ha_flushE; // @[Datapath.scala 43:10]
  assign ha_regwriteE = regwriteE; // @[Datapath.scala 209:16]
  assign ha_regwriteM = regwriteM; // @[Datapath.scala 208:16]
  assign ha_regwriteW = regwriteW; // @[Datapath.scala 210:16]
  assign ha_rsE = de_rsE; // @[Datapath.scala 211:10]
  assign ha_rtE = de_rtE; // @[Datapath.scala 212:10]
  assign ha_rsD = fdi_q[25:21]; // @[Datapath.scala 66:19]
  assign ha_rtD = fdi_q[20:16]; // @[Datapath.scala 67:19]
  assign ha_writeregE = ex_writeregE; // @[Datapath.scala 215:16]
  assign ha_writeregM = em_writeregM; // @[Datapath.scala 216:16]
  assign ha_writeregW = mw_writeregM; // @[Datapath.scala 217:16]
  assign ha_memtoregE = memtoregE; // @[Datapath.scala 219:16]
  assign ha_memtoregM = memtoregM; // @[Datapath.scala 218:16]
  assign ha_branchD = branch; // @[Datapath.scala 220:14]
  assign pcbrmux_s = pcsrc; // @[Datapath.scala 224:13]
  assign pcbrmux_d0 = pcadd1_y; // @[Datapath.scala 222:14]
  assign pcbrmux_d1 = pcadd2_y; // @[Datapath.scala 223:14]
  assign rf_clock = clock;
  assign rf_reset = reset;
  assign rf_we3 = regwriteW; // @[Datapath.scala 196:10]
  assign rf_ra1 = fdi_q[25:21]; // @[Datapath.scala 66:19]
  assign rf_ra2 = fdi_q[20:16]; // @[Datapath.scala 67:19]
  assign rf_wa3 = mw_writeregM; // @[Datapath.scala 199:10]
  assign rf_wd3 = wbmux_y; // @[Datapath.scala 200:10]
  assign pcreg_clock = clock;
  assign pcreg_reset = reset;
  assign pcreg_en = ~ha_stallF; // @[Datapath.scala 202:15]
  assign pcreg_d = pcmux_y; // @[Datapath.scala 203:11]
  assign pcadd1_a = pc; // @[Datapath.scala 205:12]
  assign pcadd1_b = 32'h4; // @[Datapath.scala 206:12]
  assign fdp_clock = clock;
  assign fdp_reset = reset;
  assign fdp_en = ~ha_stallD; // @[Datapath.scala 189:13]
  assign fdp_d = pcadd1_y; // @[Datapath.scala 190:9]
  assign fdi_clock = clock;
  assign fdi_reset = reset;
  assign fdi_en = ~ha_stallD; // @[Datapath.scala 124:13]
  assign fdi_flush = pcsrc | jump; // @[Datapath.scala 31:23]
  assign fdi_d = instr; // @[Datapath.scala 126:9]
  assign fdi_old_q = fdi_q; // @[Datapath.scala 127:13]
  assign se_a = fdi_q[15:0]; // @[Datapath.scala 129:17]
  assign immsh_a = se_y; // @[Datapath.scala 131:11]
  assign pcadd2_a = fdp_q; // @[Datapath.scala 133:12]
  assign pcadd2_b = immsh_y; // @[Datapath.scala 134:12]
  assign muxADW_s = ha_forwardADW; // @[Datapath.scala 138:12]
  assign muxADW_d0 = rf_rd1; // @[Datapath.scala 136:13]
  assign muxADW_d1 = wbmux_y; // @[Datapath.scala 137:13]
  assign muxBDW_s = ha_forwardBDW; // @[Datapath.scala 142:12]
  assign muxBDW_d0 = rf_rd2; // @[Datapath.scala 140:13]
  assign muxBDW_d1 = wbmux_y; // @[Datapath.scala 141:13]
  assign muxAD_s = ha_forwardAD; // @[Datapath.scala 146:11]
  assign muxAD_d0 = muxADW_y; // @[Datapath.scala 144:12]
  assign muxAD_d1 = aluout; // @[Datapath.scala 145:12]
  assign muxBD_s = ha_forwardBD; // @[Datapath.scala 150:11]
  assign muxBD_d0 = muxBDW_y; // @[Datapath.scala 148:12]
  assign muxBD_d1 = aluout; // @[Datapath.scala 149:12]
  assign comp_a = muxAD_y; // @[Datapath.scala 152:10]
  assign comp_b = muxBD_y; // @[Datapath.scala 153:10]
  assign de_clock = clock;
  assign de_reset = reset;
  assign de_flush = flushE; // @[Datapath.scala 155:12]
  assign de_readdata1D = muxAD_y; // @[Datapath.scala 156:17]
  assign de_readdata2D = muxBD_y; // @[Datapath.scala 157:17]
  assign de_signD = se_y; // @[Datapath.scala 158:12]
  assign de_rsD = fdi_q[25:21]; // @[Datapath.scala 66:19]
  assign de_rtD = fdi_q[20:16]; // @[Datapath.scala 67:19]
  assign de_rdD = fdi_q[15:11]; // @[Datapath.scala 68:19]
  assign ex_aluoutM = aluout; // @[Datapath.scala 172:14]
  assign ex_resultW = wbmux_y; // @[Datapath.scala 165:14]
  assign ex_rd1E = de_readdata1E; // @[Datapath.scala 166:11]
  assign ex_rd2E = de_readdata2E; // @[Datapath.scala 169:11]
  assign ex_signE = de_signE; // @[Datapath.scala 168:12]
  assign ex_alusrcE = alusrc; // @[Datapath.scala 163:14]
  assign ex_regdst = regdstE; // @[Datapath.scala 164:13]
  assign ex_rdE = de_rdE; // @[Datapath.scala 170:10]
  assign ex_rtE = de_rtE; // @[Datapath.scala 171:10]
  assign ex_forwardaE = ha_forwardAE; // @[Datapath.scala 173:16]
  assign ex_forwardbE = ha_forwardBE; // @[Datapath.scala 174:16]
  assign ex_alucontrolE = alucontrol; // @[Datapath.scala 167:18]
  assign em_clock = clock;
  assign em_writeregE = ex_writeregE; // @[Datapath.scala 176:16]
  assign em_aluoutE = ex_aluoutE; // @[Datapath.scala 177:14]
  assign em_writedataE = ex_writedataE; // @[Datapath.scala 178:17]
  assign mw_clock = clock;
  assign mw_writeregE = em_writeregM; // @[Datapath.scala 180:16]
  assign mw_aluoutE = aluout; // @[Datapath.scala 181:14]
  assign mw_writedataE = readdataM; // @[Datapath.scala 182:16]
  assign wbmux_s = memtoregW; // @[Datapath.scala 185:11]
  assign wbmux_d0 = mw_aluoutM; // @[Datapath.scala 186:12]
  assign wbmux_d1 = mw_writedataM; // @[Datapath.scala 187:12]
  assign pcmux_s = jump; // @[Datapath.scala 194:11]
  assign pcmux_d0 = pcbrmux_y; // @[Datapath.scala 192:12]
  assign pcmux_d1 = {pcmux_d1_hi,2'h0}; // @[Cat.scala 31:58]
endmodule
module Mips(
  input         clock,
  input         reset,
  input  [31:0] instr,
  input  [31:0] readdata,
  output [31:0] pc,
  output        memwriteM,
  output [31:0] aluout,
  output [31:0] writedataM
);
  wire  c_clock; // @[Mips.scala 15:17]
  wire  c_reset; // @[Mips.scala 15:17]
  wire [5:0] c_op; // @[Mips.scala 15:17]
  wire [5:0] c_funct; // @[Mips.scala 15:17]
  wire  c_flushE; // @[Mips.scala 15:17]
  wire  c_zero; // @[Mips.scala 15:17]
  wire  c_memtoregE; // @[Mips.scala 15:17]
  wire  c_memtoregM; // @[Mips.scala 15:17]
  wire  c_memtoregW; // @[Mips.scala 15:17]
  wire  c_memwriteM; // @[Mips.scala 15:17]
  wire  c_branch; // @[Mips.scala 15:17]
  wire  c_pcsrc; // @[Mips.scala 15:17]
  wire  c_alusrc; // @[Mips.scala 15:17]
  wire  c_regdstE; // @[Mips.scala 15:17]
  wire  c_regwriteE; // @[Mips.scala 15:17]
  wire  c_regwriteM; // @[Mips.scala 15:17]
  wire  c_regwriteW; // @[Mips.scala 15:17]
  wire  c_jump; // @[Mips.scala 15:17]
  wire [2:0] c_alucontrol; // @[Mips.scala 15:17]
  wire  dp_clock; // @[Mips.scala 30:18]
  wire  dp_reset; // @[Mips.scala 30:18]
  wire  dp_memtoregE; // @[Mips.scala 30:18]
  wire  dp_memtoregM; // @[Mips.scala 30:18]
  wire  dp_memtoregW; // @[Mips.scala 30:18]
  wire  dp_branch; // @[Mips.scala 30:18]
  wire  dp_pcsrc; // @[Mips.scala 30:18]
  wire  dp_alusrc; // @[Mips.scala 30:18]
  wire  dp_regdstE; // @[Mips.scala 30:18]
  wire  dp_regwriteE; // @[Mips.scala 30:18]
  wire  dp_regwriteM; // @[Mips.scala 30:18]
  wire  dp_regwriteW; // @[Mips.scala 30:18]
  wire  dp_jump; // @[Mips.scala 30:18]
  wire [2:0] dp_alucontrol; // @[Mips.scala 30:18]
  wire [31:0] dp_instr; // @[Mips.scala 30:18]
  wire [31:0] dp_readdataM; // @[Mips.scala 30:18]
  wire  dp_zero; // @[Mips.scala 30:18]
  wire [31:0] dp_pc; // @[Mips.scala 30:18]
  wire [31:0] dp_aluout; // @[Mips.scala 30:18]
  wire [31:0] dp_writedataM; // @[Mips.scala 30:18]
  wire [5:0] dp_op; // @[Mips.scala 30:18]
  wire [5:0] dp_funct; // @[Mips.scala 30:18]
  wire  dp_flushE; // @[Mips.scala 30:18]
  Ctrl c ( // @[Mips.scala 15:17]
    .clock(c_clock),
    .reset(c_reset),
    .op(c_op),
    .funct(c_funct),
    .flushE(c_flushE),
    .zero(c_zero),
    .memtoregE(c_memtoregE),
    .memtoregM(c_memtoregM),
    .memtoregW(c_memtoregW),
    .memwriteM(c_memwriteM),
    .branch(c_branch),
    .pcsrc(c_pcsrc),
    .alusrc(c_alusrc),
    .regdstE(c_regdstE),
    .regwriteE(c_regwriteE),
    .regwriteM(c_regwriteM),
    .regwriteW(c_regwriteW),
    .jump(c_jump),
    .alucontrol(c_alucontrol)
  );
  Datapath dp ( // @[Mips.scala 30:18]
    .clock(dp_clock),
    .reset(dp_reset),
    .memtoregE(dp_memtoregE),
    .memtoregM(dp_memtoregM),
    .memtoregW(dp_memtoregW),
    .branch(dp_branch),
    .pcsrc(dp_pcsrc),
    .alusrc(dp_alusrc),
    .regdstE(dp_regdstE),
    .regwriteE(dp_regwriteE),
    .regwriteM(dp_regwriteM),
    .regwriteW(dp_regwriteW),
    .jump(dp_jump),
    .alucontrol(dp_alucontrol),
    .instr(dp_instr),
    .readdataM(dp_readdataM),
    .zero(dp_zero),
    .pc(dp_pc),
    .aluout(dp_aluout),
    .writedataM(dp_writedataM),
    .op(dp_op),
    .funct(dp_funct),
    .flushE(dp_flushE)
  );
  assign pc = dp_pc; // @[Mips.scala 32:6]
  assign memwriteM = c_memwriteM; // @[Mips.scala 19:13]
  assign aluout = dp_aluout; // @[Mips.scala 33:10]
  assign writedataM = dp_writedataM; // @[Mips.scala 34:14]
  assign c_clock = clock;
  assign c_reset = reset;
  assign c_op = dp_op; // @[Mips.scala 39:8]
  assign c_funct = dp_funct; // @[Mips.scala 40:11]
  assign c_flushE = dp_flushE; // @[Mips.scala 41:12]
  assign c_zero = dp_zero; // @[Mips.scala 42:10]
  assign dp_clock = clock;
  assign dp_reset = reset;
  assign dp_memtoregE = c_memtoregE; // @[Mips.scala 44:16]
  assign dp_memtoregM = c_memtoregM; // @[Mips.scala 45:16]
  assign dp_memtoregW = c_memtoregW; // @[Mips.scala 46:16]
  assign dp_branch = c_branch; // @[Mips.scala 48:13]
  assign dp_pcsrc = c_pcsrc; // @[Mips.scala 47:12]
  assign dp_alusrc = c_alusrc; // @[Mips.scala 49:13]
  assign dp_regdstE = c_regdstE; // @[Mips.scala 50:14]
  assign dp_regwriteE = c_regwriteE; // @[Mips.scala 51:16]
  assign dp_regwriteM = c_regwriteM; // @[Mips.scala 52:16]
  assign dp_regwriteW = c_regwriteW; // @[Mips.scala 53:16]
  assign dp_jump = c_jump; // @[Mips.scala 54:11]
  assign dp_alucontrol = c_alucontrol; // @[Mips.scala 55:17]
  assign dp_instr = instr; // @[Mips.scala 56:12]
  assign dp_readdataM = readdata; // @[Mips.scala 57:16]
endmodule
module Top(
  input         clock,
  input         reset,
  output [31:0] dataaddr,
  output [31:0] writedata,
  output        memwrite
);
  wire  mips_clock; // @[Top.scala 11:20]
  wire  mips_reset; // @[Top.scala 11:20]
  wire [31:0] mips_instr; // @[Top.scala 11:20]
  wire [31:0] mips_readdata; // @[Top.scala 11:20]
  wire [31:0] mips_pc; // @[Top.scala 11:20]
  wire  mips_memwriteM; // @[Top.scala 11:20]
  wire [31:0] mips_aluout; // @[Top.scala 11:20]
  wire [31:0] mips_writedataM; // @[Top.scala 11:20]
  wire [5:0] imem_a; // @[Top.scala 17:20]
  wire [31:0] imem_rd; // @[Top.scala 17:20]
  wire  dmem_we; // @[Top.scala 20:20]
  wire [31:0] dmem_a; // @[Top.scala 20:20]
  wire [31:0] dmem_wd; // @[Top.scala 20:20]
  wire [31:0] dmem_rd; // @[Top.scala 20:20]
  Mips mips ( // @[Top.scala 11:20]
    .clock(mips_clock),
    .reset(mips_reset),
    .instr(mips_instr),
    .readdata(mips_readdata),
    .pc(mips_pc),
    .memwriteM(mips_memwriteM),
    .aluout(mips_aluout),
    .writedataM(mips_writedataM)
  );
  imem imem ( // @[Top.scala 17:20]
    .a(imem_a),
    .rd(imem_rd)
  );
  dmem dmem ( // @[Top.scala 20:20]
    .we(dmem_we),
    .a(dmem_a),
    .wd(dmem_wd),
    .rd(dmem_rd)
  );
  assign memwrite = mips_memwriteM; // @[Top.scala 13:12]
  assign dataaddr = mips_aluout; // @[Top.scala 14:12]
  assign writedata = mips_writedataM; // @[Top.scala 15:13]
  assign mips_clock = clock;
  assign mips_reset = reset;
  assign mips_instr = imem_rd; // @[Top.scala 24:14]
  assign mips_readdata = dmem_rd; // @[Top.scala 23:17]
  assign imem_a = mips_pc[7:2]; // @[Top.scala 26:15]
  assign dmem_we = memwrite; // @[Top.scala 28:11]
  assign dmem_a = dataaddr; // @[Top.scala 29:10]
  assign dmem_wd = writedata; // @[Top.scala 30:11]
endmodule
