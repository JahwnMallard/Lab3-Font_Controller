Lab3- Font controller
=========

C2C John Miller

VHDL Code to generate font via a VGA signal



This code also supports the use of the switches on the Atlys board for selecting specific ASCII characters.

The major problems that this project dealt with were:
* Utilizing the already made vga modules and creating a dynamic image as opposed to a static one
* Implementing multiple state machines within the same module
* Finding a hardware based solution to debouncing, as opposed to a software based on that would be available in a programming language.
* Being able to use a clock that updates in a matter of nanoseconds to create a game that is playable by humans.


Version
----

1.1 - Generates characters based on switch positions and button inputs

Previous Versions
----
* 1.0 - Basic Font functionality

Works in Progress
----
* 1.2 - Allow for input to the board via NES controller

Implementation
-----------
This project did not rely as heavily on finite state machines as the previous lab, instead, it was more reliant on being able to connect prexisting modules together. 
There was a lot of timing to take into consideration, as some signals needed to be delayed in order to sync up the timing of the modules

The following basic constructs were used to realize the font controller:

Flip-flop (memory element):

```Vhdl
    process(clk) is
    begin
        if(rising_edge(clk)) then
            col_next_2 <= col_next_1;
        	end if;
    end process;

```
Mux (selector)

```Vhdl
    process(sel, data) is
    begin
    
        if( sel = "000") then
            output <= data(7);
        elsif(sel = "001") then
        	output <= data(6);
        elsif(sel = "010") then
        	output <= data(5);
        elsif(sel <="011") then
        	output <= data(4);
        elsif(sel <="100") then
        	output <= data(3);
        elsif(sel <="101") then
        	output <= data(2);
        elsif(sel <= "110") then
        	output <= data(1);
        else
        	output <= data(0);
        end if;
    
    end process;
```


The following modules were to implement the game
* h_sync_gen.vhd - Synchronizes the horizontal aspect of the signal
* v_sync_gen.vhd - Synchronizes the vertical aspect of the signal
* vga_sync.vhd - Synchronizes the h_sync and v_sync signals to specify a specific pixel 
* input_to_pulse.vhd - Debounces the button inputs to make sure that each button press is only accounted for once.
* character_gen.vhd - Updates the game state based on ball position, paddle position, as well as external inputs to the board.
* pixel_gen.vhd - Displays the game based on the outputs of the pong_control module
* atlys_lab_video.vhd - Top-shell module
* dvid.vhd - Outputs the HDMI signal (converted by hardware to vga)



The modules are connected as shown below:
* Note that this diagram is a representation of A functionality, which is a work in progress

![block diagram](block_diagram.jpg)


Troubleshooting
--------------

The biggest troubles I had can be separated by module:

character_gen.vhd:
* There was a lot of misunderstanding in creating the function to specify the row and column address for the char_screen_buffer

```vhdl 
    row_col_multiply <= std_logic_vector(((unsigned(row(10 downto 4)) * 80) + unsigned(column(10 downto 3))));
    row_col_multiply_12 <= row_col_multiply(11 downto 0);
```

atlys_lab.vhd:
* The only major problem was being able to add in proper delays for the signals, there were too many signals being delayed, so that messed with the inputs to character_gen, which often resulted in the overall output being correct, with the exception of some bleeding on the edge of the screen.

Confirming functionality
--------------

There was a bit of serendipity in this assignment, as the font that displayed was very close to correct without much debugging. It was very incremental in designing it, the general process was write, check syntax, check if it synthesizes.

There was some debouncing required at the start of testing b-functionality, which was alleviated by increasing the delay in the debounce code. 

The hardest thing to test, and still is, is the NES functionality. I think I have a problem with a feedback loop, because my signal references itself. However, I had  a considerable amount of classwork due for other classes, so I was not able to get the NES functionality.

Lessons Learned
---

* Rely on the diagram given, if it work for the instructor, it is probably correct.
* Don't assume that because required and B funcitonality were quick ordeals, that A funcitonality will be.
* Check wiring when plugging in NES controllers.



##### TODO


* convert code to use generics
* test reset cases
* Magic numbers, how do they work?

Documentation
----

C2C Ryan Good helped me make the function
