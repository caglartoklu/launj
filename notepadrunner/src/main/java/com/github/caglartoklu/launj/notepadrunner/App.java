package com.github.caglartoklu.launj.notepadrunner;

// import java.io.File;
import java.io.IOException;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ) throws IOException
    {
        System.out.println( "Hello World!" );
        for (String arg : args) {
            launchWithNotepad(arg);
        }
    }

    public static void launchWithNotepad(String fileName) throws IOException {
        ProcessBuilder pb = new ProcessBuilder("notepad", fileName);
        // pb.directory(new File("myDir"));
        Process p = pb.start();
    }
}
