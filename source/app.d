import std.stdio;
import std.algorithm;

void main()
{
    writeln("Hello, D World!");
    writeln("This is a D programming language example.");
    
    // Demonstrate some D features
    auto numbers = [1, 2, 3, 4, 5];
    writeln("Numbers: ", numbers);
    
    auto doubled = numbers.map!(x => x * 2);
    writeln("Doubled: ", doubled);
}