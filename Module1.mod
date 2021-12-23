MODULE Module1
    CONST robtarget home1:=[[806.2169,8.004976,1152.917],[0.4985155,-0.02314875,0.8664497,-0.01454107],[-1,-1,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    
    CONST robtarget StartingPt:=[[620,-710.0001,415.0901],[0.339608,0.4965242,0.7883506,-0.1289709],[-1,0,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    PROC main()

        VAR num charHight  := 90;   ! single charector height
        VAR num charWidth  := 60;   ! single charector width
        VAR num wordWidth  := 810;  ! horizondal distance after one word
        VAR num wordHeight := 270;  ! vertical diatance after one word
        VAR num N          := 2;    ! number of rows
        VAR num M          := 2;    ! number of column
        VAR bool status;            ! for future use
        Reset DO1;
         Movej home1, v1000, z50, MyTool;
        Movej StartingPt,v1000,z50,MyTool;
        
        status := drawWordNbyM(N, M, charHight, charWidth, wordWidth, wordHeight);!calling the function that calls all other functions
    
    ENDPROC
    
    FUNC bool drawWordNbyM(num N, num M, num charHight, num charWidth, num wordWidth, num wordHeight)

        VAR bool finished := TRUE;  ! for future use
        VAR robtarget next;         ! for iterations
        VAR robtarget backup;       ! for iterations
        VAR num i := 1;             ! for iterations
        VAR num j := 1;             ! for iterations
        next := StartingPt;         ! the very starting point being left top most point that robot can reach.
        
        FOR i FROM 1 TO N DO        ! taking each row element
            backup := next;         ! the starting point of each row
            FOR j FROM 1 TO M DO    ! taking each element within a rwo. [colum wise iteration]
                next := char_OX(next, charHight, 0, 0);!calling symbol function
                next := drawletterL(next, charHight, charWidth);!calling Letter L function
                next := drawletterA(next, charHight, charWidth);!calling Letter A function
                next := drawletterK(next, charHight, charWidth);!calling Letter  K function
                next := drawnumber9(next,charHight, charWidth);!calling NUMBER 9 function
                next := drawNumber7(next,charHight, charWidth);!calling NUMBER 7 function
                next := drawnumber8(next,charHight, charWidth);!calling NUMBER 8 function
                next := Offs(backup,0, wordWidth, 0);
            ENDFOR
            next := Offs(backup, wordHeight, 0, 0);      ! moving to next row's left top most point
        ENDFOR

    RETURN finished;    ! for future use
    ENDFUNC
        
    FUNC robtarget char_OX (robtarget refpt, num d, num x_off, num y_off)
        
        VAR robtarget nextRefpt;
        VAR num char_off;
        
        nextRefpt   := Offs(refpt, 0,(d+(d/5)), 0);
        char_off:=(d/2)*(1-sin(45));
        
        MoveJ Offs(refpt,x_off+char_off,y_off+char_off,50),v500,z5,MyTool;
        MoveL Offs(refpt,x_off+char_off,y_off+char_off,0),v500,fine,MyTool;

        Set DO1;
        MoveC offs(refpt,x_off+char_off,y_off+d-char_off,0),Offs(refpt,x_off+(d-char_off),y_off+(d-char_off),0),v500,fine,MyTool;
        MoveL Offs(refpt,x_off+char_off,y_off+char_off,0),v500,fine,MyTool;
        MoveC offs(refpt,x_off+d-char_off,y_off+char_off,0),Offs(refpt,x_off+d-char_off,y_off+d-char_off,0),v500,fine,MyTool;


        Reset DO1;
        MoveJ Offs(refpt,x_off+char_off,y_off+d-char_off,0),v500,fine,MyTool;

        Set DO1;
        MoveC offs(refpt,x_off+d-char_off,y_off+d-char_off,0),Offs(refpt,x_off+(d-char_off),y_off+(char_off),0),v500,fine,MyTool;
        MoveL Offs(refpt,x_off+char_off,y_off+d-char_off,0),v500,fine,MyTool;
    
        Reset DO1;
        MoveJ Offs(refpt,x_off,y_off+d*0.1+d*0.5,50),v500,z5,MyTool;

        RETURN nextRefpt;

    ENDFUNC
         
    FUNC robtarget drawletterL( robtarget refpt,  num fontHeight, num fontWidth)

        !(0,0)-------------> X
        ! |  L1
        ! |  -
        ! |  -
        ! |  -
        ! |  -
        ! |  L2 ----- L3
        ! Y

        VAR robtarget nextRefpt;
        VAR robtarget l1;
        VAR robtarget l2;
        VAR robtarget l3;
        VAR num xof_l1l2;
        VAR num xof_l3;

        nextRefpt   := Offs(refpt, 0,fontWidth, 0);
        xof_l1l2    := fontWidth * .0834;    ! from the drawing 8.34% of width from left
        xof_l3      := fontWidth - xof_l1l2; ! from the drawing 8.34% of width from right

        l1 := Offs(refpt, 0, xof_l1l2, 0);
        l2 := Offs(refpt,fontHeight,xof_l1l2, 0);
        l3 := Offs(refpt, fontHeight,xof_l3,  0);

        SetDO DO1,0;
        MoveL refpt,v100,fine,MyTool\WObj:=wobj0;
        MoveL l1,v100,fine,MyTool\WObj:=wobj0;
        SetDO DO1,1;
        MoveL l2,v100,z10,MyTool\WObj:=wobj0;
        MoveL l3,v100,z10,MyTool\WObj:=wobj0;
        MoveL l2,v100,z10,MyTool\WObj:=wobj0;
        MoveL l1,v100,z10,MyTool\WObj:=wobj0;
        SetDO DO1,0;
        !MoveL refpt,v100,z10,MyTool\WObj:=wobj0;
        MoveJ nextRefpt,v100,z10,MyTool\WObj:=wobj0;

    RETURN nextRefpt;
    ENDFUNC
    
    FUNC robtarget drawletterA( robtarget refpt,  num fontHeight, num fontWidth)

        !(0,0)-------------> X
        ! |         A3
        ! |       /   \
        ! |     A2 --- A4
        ! |    /         \
        ! |  A1           A5
        ! Y

        VAR robtarget nextRefpt;
        VAR robtarget a1;
        VAR robtarget a2;
        VAR robtarget a3;
        VAR robtarget a4;
        VAR robtarget a5;
        VAR num yof_a3;
        VAR num yof_a2a4;
        VAR num xof_a1;
        VAR num xof_a2;
        VAR num xof_a3;
        VAR num xof_a4;
        VAR num xof_a5;

        nextRefpt := Offs(refpt,  0,fontWidth, 0);
        xof_a1 := fontWidth * 0.1; ! from the drawing 8.34% of char width
        xof_a5 := fontWidth - xof_a1;
        a1 := Offs(refpt,fontHeight,xof_a1, 0);
        a5 := Offs(refpt, fontHeight, xof_a5, 0);

        xof_a3 := fontWidth * 0.5;  ! from the drawing 50% of char width
        a3 := Offs(refpt,  0,xof_a3, 0);

        yof_a2a4 := fontHeight / 2; ! from the drawing 50% of height
        xof_a2 := (((xof_a3-xof_a1) * (yof_a2a4-0)) / (0-fontHeight)) + xof_a3;         ! line equation y=mx+c
        xof_a4 := (((xof_a5-xof_a3) * (yof_a2a4-fontHeight)) / (fontHeight-0)) + xof_a5;! line equation y=mx+c

        a2 := Offs(refpt, yof_a2a4, xof_a2, 0);
        a4 := Offs(refpt, yof_a2a4, xof_a4, 0);

        SetDO DO1,0;
        MoveL refpt,v100,fine,MyTool\WObj:=wobj0;
        MoveL a1,v100,fine,MyTool\WObj:=wobj0;
        SetDO DO1,1;
        MoveL a3,v100,fine,MyTool\WObj:=wobj0;
        MoveL a5,v100,fine,MyTool\WObj:=wobj0;
        MoveL a4,v100,fine,MyTool\WObj:=wobj0;
        MoveL a2,v100,fine,MyTool\WObj:=wobj0;
        MoveL a1,v100,fine,MyTool\WObj:=wobj0;
        
        
        SetDO DO1,0;
        !MoveL refpt,v100,fine,MyTool\WObj:=wobj0;
        MoveJ nextRefpt,v100,fine,MyTool\WObj:=wobj0;        

    RETURN nextRefpt;
    ENDFUNC
    
    FUNC robtarget drawletterK( robtarget refpt, num fontHeight, num fontWidth)

        !(0,0)----------> X
        ! |  K1    K4
        ! |  -   /
        ! |  K2
        ! |  -   \
        ! |  K3    K5
        ! Y

        VAR robtarget nextRefpt;
        VAR robtarget k1;
        VAR robtarget k2;
        VAR robtarget k3;
        VAR robtarget k4;
        VAR robtarget k5;
        VAR num xof_k1k2k3;
        VAR num xof_k4k5;
        VAR num yof_k2;

        nextRefpt   := Offs(refpt,  0,fontWidth, 0);
        xof_k1k2k3  := fontWidth * 0.0834;  ! from the drawing 8.34% of width from left
        yof_k2      := fontHeight/2;        ! from the drawing 50% of height

        k1 := Offs(refpt, 0, xof_k1k2k3, 0);
        k2 := Offs(refpt ,yof_k2, xof_k1k2k3, 0);
        k3 := Offs(refpt, fontHeight,xof_k1k2k3, 0);

        xof_k4k5    := fontWidth - xof_k1k2k3; ! from the drawing 8.34% of width from right

        k4 := Offs(refpt, 0, xof_k4k5, 0);
        k5 := Offs(refpt, fontHeight, xof_k4k5, 0);

        SetDO DO1,0;
        MoveL refpt,v100,fine,MyTool\WObj:=wobj0;
        MoveL k1,v100,fine,MyTool\WObj:=wobj0;
        SetDO DO1,1;
        MoveL k3,v100,fine,MyTool\WObj:=wobj0;
        MoveL k2,v100,z10,MyTool\WObj:=wobj0;
        MoveL k4,v100,z10,MyTool\WObj:=wobj0;
        MoveL k2,v100,z10,MyTool\WObj:=wobj0;
        MoveL k3,v100,z10,MyTool\WObj:=wobj0;
        MoveL k1,v100,z10,MyTool\WObj:=wobj0;
        MoveL k2,v100,z10,MyTool\WObj:=wobj0;
        MoveL k5,v100,fine,MyTool\WObj:=wobj0;
        MoveL k2,v100,z10,MyTool\WObj:=wobj0;
        MoveL k1,v100,z10,MyTool\WObj:=wobj0;
        SetDO DO1,0;
        !MoveL refpt,v100,fine,MyTool\WObj:=wobj0;
        MoveJ nextRefpt,V100,fine,MyTool\WObj:=wobj0;

    RETURN nextRefpt;
    ENDFUNC

    FUNC robtarget drawnumber9(robtarget refpt,  num fontHeight, num fontWidth)

        !(0,0)-------------> X
        ! |  N4 -- N3
        ! |  -     s
        ! |  N5 -- N2
        ! |        /
        ! |      /
        ! |    /
        ! |  N1
        ! Y

        VAR robtarget nextRefpt;
        VAR robtarget n1;
        VAR robtarget n2;
        VAR robtarget s;    ! to minimze the arc error
        VAR robtarget n3;
        VAR robtarget n4;
        VAR robtarget n5;
        VAR num xof_n1n4n5;
        VAR num xof_n2n3;
        VAR num yof_n4n3;
        VAR num yof_n5n2;

        nextRefpt   := Offs(refpt, 0, fontWidth, 0);
        xof_n1n4n5  := 1*(((1*fontWidth)-(fontHeight/2))/2); ! the upper ring's aproximate diameter should be half of the total char height. Multiplying by -1 is just for adjusting the cordingates.
        xof_n2n3    := fontWidth - xof_n1n4n5;
        yof_n4n3    := 0;
        yof_n5n2    := fontHeight * 0.45;

        n1 := Offs(refpt, fontHeight, xof_n1n4n5, 0);
        n2 := Offs(refpt, yof_n5n2, xof_n2n3, 0);
        s  := Offs(refpt, (yof_n5n2/3),xof_n2n3, 0);
        n3 := Offs(refpt, yof_n4n3, xof_n2n3, 0);
        n4 := Offs(refpt, yof_n4n3, xof_n1n4n5, 0);
        n5 := Offs(refpt, yof_n5n2, xof_n1n4n5, 0);

        SetDO DO1,0;
        MoveL refpt,v100,fine,MyTool\WObj:=wobj0;
        MoveL n1,v100,fine,MyTool\WObj:=wobj0;
        SetDO DO1,1;
        MoveL n2,v100,z30,MyTool\WObj:=wobj0;
        MoveL n3,v100,z30,MyTool\WObj:=wobj0;
        MoveL n4,v100,z30,MyTool\WObj:=wobj0;
        MoveL n5,v100,z30,MyTool\WObj:=wobj0;
        MoveL n2,v100,z30,MyTool\WObj:=wobj0;
        MoveL s,v100,z30,MyTool\WObj:=wobj0;
        MoveL n2,v100,z30,MyTool\WObj:=wobj0;
        MoveL n1,v100,z10,MyTool\WObj:=wobj0;
        SetDO DO1,0;
        !MoveL refpt,v100,z10,MyTool\WObj:=wobj0;
        MoveJ nextRefpt,v100,z10,MyTool\WObj:=wobj0;

    RETURN nextRefpt;
    ENDFUNC

    FUNC robtarget drawNumber7( robtarget refpt, num fontHeight, num fontWidth)

        !(0,0)-------------> X
        ! |    S1----S2
        ! |         /
        ! |        /
        ! |       /
        ! |      /
        ! |    S3
        ! Y

        VAR robtarget nextRefpt;
        VAR robtarget s1;
        VAR robtarget s2;
        VAR robtarget s3;
        VAR num xof_s1s3;
        VAR num xof_s2;

        nextRefpt   := Offs(refpt, 0, fontWidth, 0);
        xof_s1s3  := ((1*fontWidth)-(fontHeight/2))/2;
        xof_s2      := fontWidth - xof_s1s3; ! from the drawing 8.34% of width from right

        s1 := Offs(refpt, 0, xof_s1s3, 0);
        s2 := Offs(refpt, 0,xof_s2, 0);
        s3 := Offs(refpt, fontHeight, xof_s1s3, 0);

        SetDO DO1,0;
        MoveL refpt,v100,fine,MyTool\WObj:=wobj0;
        MoveL s1,v100,fine,MyTool\WObj:=wobj0;
        SetDO DO1,1;
        MoveL s2,v100,z10,MyTool\WObj:=wobj0;
        MoveL s3,v100,z10,MyTool\WObj:=wobj0;
        MoveL s2,v100,z10,MyTool\WObj:=wobj0;
        MoveL s1,v100,z10,MyTool\WObj:=wobj0;
        SetDO DO1,0;
        !MoveL refpt,v100,z10,MyTool\WObj:=wobj0;
        MoveJ nextRefpt,v100,z10,MyTool\WObj:=wobj0;

    RETURN nextRefpt;
    ENDFUNC
    
    FUNC robtarget drawnumber8(robtarget refpt,  num fontHeight, num fontWidth)

        !(0,0)-------------> X
        ! |  N5 --- N6
        ! |  -      -
        ! |  N4 --- N3
        ! |  -      -
        ! |  N1 --- N2
        ! Y

        VAR robtarget nextRefpt;
        VAR robtarget n1;
        VAR robtarget n2;
        VAR robtarget n3;
        VAR robtarget n4;
        VAR robtarget n5;
        VAR robtarget n6;
        VAR robtarget s;
        VAR num xof_n1n4n5;
        VAR num xof_n2n3n6;
        VAR num yof_n4n3;
        VAR num yof_n5n2;

        nextRefpt   := Offs(refpt,0,fontWidth, 0);
        xof_n1n4n5  := -1*(((-1*fontWidth)-(fontHeight/2))/2); ! Rings aproximate diameter should be half of the total char height.
        xof_n2n3n6  := fontWidth - xof_n1n4n5;
        yof_n4n3    := fontHeight/2;

        n1 := Offs(refpt, fontHeight, xof_n1n4n5, 0);
        n2 := Offs(refpt, fontHeight, xof_n2n3n6, 0);
        n6 := Offs(refpt, 0, xof_n2n3n6, 0);
        n3 := Offs(refpt, yof_n4n3, xof_n2n3n6, 0);
        n4 := Offs(refpt, yof_n4n3, xof_n1n4n5, 0);
        n5 := Offs(refpt, 0, xof_n1n4n5, 0);

        SetDO DO1,0;
        MoveL refpt,v100,fine,MyTool\WObj:=wobj0;
        MoveL n4,v100,fine,MyTool\WObj:=wobj0;
        SetDO DO1,1;
        MoveL n1,v100,z10,MyTool\WObj:=wobj0;
        MoveL n2,v100,z10,MyTool\WObj:=wobj0;
        MoveL n3,v100,z10,MyTool\WObj:=wobj0;
        MoveL n4,v100,z10,MyTool\WObj:=wobj0;
        MoveL n5,v100,z10,MyTool\WObj:=wobj0;
        MoveL n6,v100,z10,MyTool\WObj:=wobj0;
        MoveL n3,v100,z10,MyTool\WObj:=wobj0;
        MoveL n4,v100,z10,MyTool\WObj:=wobj0;
        MoveL n1,v100,z10,MyTool\WObj:=wobj0;
        Reset DO1;
        MoveL n2,v100,z30,MyTool\WObj:=wobj0;
        MoveL n1,v100,z30,MyTool\WObj:=wobj0;
        MoveL n4,v100,z30,MyTool\WObj:=wobj0;
        !MoveL refpt,v100,z5,MyTool\WObj:=wobj0;
        Movej nextRefpt,v100,z10,MyTool\WObj:=wobj0;

    RETURN nextRefpt;
    ENDFUNC

ENDMODULE