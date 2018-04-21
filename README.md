# LaunJ

A mere Windows `.exe` file that can be distributed with your `.jar` files to easily launch them.

The exe file itself is built with [FreeBASIC](https://freebasic.net/).
So it is actually a BASIC language project.
It also includes a simple and sample Java project called _notepadrunner_.



### Benefits:

- Your program will have a pretty icon.
- It can easily be added to Start Menu.
- The directory can be added to [PATH variables](https://www.java.com/en/download/help/path.xml), and can be launched from command line.
- All the facilities of Windows for exe file will work. ([SendTo](https://www.howtogeek.com/howto/windows-vista/customize-the-windows-vista-send-to-menu/), [Open With](https://techforluddites.com/windows-10-change-the-default-programs-for-opening-files/), drag and drop etc.)
- It works with file names including unicode characters.
- It works with file names with spaces.
- It works within directories with unicode characters and spaces.



# Usage

### Most simple method:

- Clone/download this repository, or download the latest files from from _releases_ page.
- Copy `launj.exe` next to your jar file.
- Rename `launj.exe` with the same name of your `.jar` file.
If the name of the file is `foobar.jar`, rename `launj.exe` as `foobar.exe`.
It locates the `.jar` file via its own executable name in the same directory.

Done.
This is all needed to have a working executable for a jar file.

### Additional (changing icon method 1):

- Download [Greenfish Icon Editor Pro](http://greenfishsoftware.org/gfie.php).
- Open the exe file with Greenfish Icon Editor Pro.
- Set the new icon, save and exit.

### Additional (changing icon method 2):

- Download [FreeBASIC](https://freebasic.net/)
- Extract it somewhere, let us assume it is `C:\FreeBASIC`.
- Edit `launj.ico` or overwrite it with a new icon.
- Type the following command and compile the project:

```
cd C:\path\to\projects\launj
C:\FreeBASIC\fbc.exe -s gui launj.bas launj.rc
```

At this point, you will have the same executable with a customized icon.

Here is an animated gif after demonstrating the usage after download the release:

![launj_usage_1]
(https://user-images.githubusercontent.com/2071639/39084259-2bcd350e-457b-11e8-85ff-ad105bb1eafc.gif)

# FAQ

### Why FreeBASIC?

It produces very small executables, it is fast, allows to add icons to console executables, it is free software, it does not have any extra dependencies (no runtimes etc), and it is enough for the task.

### Do you mind to change it later?

If a new requirement that can not be accomplished is considered, the launcher executable can be re-written.

### Is JRE still needed?

Yes, JRE is still needed to run your `.jar` file.
LaunJ has nothing to do with the contents or jar files.

### BitDefender warns me about malicious behaviour, why is that?

Because, a program is running another.
And, when you compile the source code, the signature of the exe file is changed.
Some antivirus programs are sensitive to that.
You have the source code, you can recompile it as you wish.



# System Requirements

- A `.jar` file of your own to launch.
- `launj.exe` itself only.
- optional: [FreeBASIC](https://freebasic.net/), if you want to customize `launj.exe` and change the default icon.
- optional: if you don't want to customize the launcher but only want to change the icon, you can use [Greenfish Icon Editor Pro](http://greenfishsoftware.org/gfie.php) to simply change the icon in the exe file.
- A Windows operating system, since the process is useful on Windows only.



# Sample Java Project

The following is not required, and its only purpose is information.
A sample `.jar` produced by the following steps is contained in the repository to so that you can test it as batteries included.

This is how you build a `.jar` file with Maven, without Eclipse or any other IDE.


```sh
mvn --version
```

```
Apache Maven 3.3.9 (bb52d8502b132ec0a5a3f4c09453c07478323dc5; 2015-11-10T18:41:47+03:00)
Maven home: C:\bin\apache-maven\bin\..
Java version: 1.8.0_131, vendor: Oracle Corporation
Java home: C:\Program Files\Java\jdk1.8.0_131\jre
Default locale: en_US, platform encoding: Cp1254
OS name: "windows 10", version: "10.0", arch: "amd64", family: "dos"
```

Type the following command (a single line command) to create the sample project:

```sh
mvn archetype:generate -DgroupId=com.github.caglartoklu.launj -DartifactId=notepadrunner -Dpackage=com.github.caglartoklu.launj.notepadrunner -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

```
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Maven Stub Project (No POM) 1
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] >>> maven-archetype-plugin:3.0.1:generate (default-cli) > generate-sources @ standalone-pom >>>
[INFO]
[INFO] <<< maven-archetype-plugin:3.0.1:generate (default-cli) < generate-sources @ standalone-pom <<<
[INFO]
[INFO] --- maven-archetype-plugin:3.0.1:generate (default-cli) @ standalone-pom ---
[INFO] Generating project in Batch mode
[INFO] ----------------------------------------------------------------------------
[INFO] Using following parameters for creating project from Old (1.x) Archetype: maven-archetype-quickstart:1.0
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: basedir, Value: C:\projects\launj
[INFO] Parameter: package, Value: com.github.caglartoklu.launj.notepadrunner
[INFO] Parameter: groupId, Value: com.github.caglartoklu.launj
[INFO] Parameter: artifactId, Value: notepadrunner
[INFO] Parameter: packageName, Value: com.github.caglartoklu.launj.notepadrunner
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] project created from Old (1.x) Archetype in dir: C:\projects\launj\notepadrunner
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 4.541 s
[INFO] Finished at: 2018-04-21T11:09:58+03:00
[INFO] Final Memory: 17M/301M
[INFO] ------------------------------------------------------------------------
```


Before the compilation, add the following to `pom.xml` file.
This will help to build an _executable jar_ where you don't need to pass the classpath everytime.

```xml
    <build>
        <plugins>
            <plugin>
                <!-- Build an executable JAR -->
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.0.2</version>
                <configuration>
                    <archive>
                        <manifest>
                            <addClasspath>true</addClasspath>
                            <classpathPrefix>lib/</classpathPrefix>
                            <mainClass>com.github.caglartoklu.launj.notepadrunner.App</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
        </plugins>
    </build>
```

Now you can compile the project using the following commands:

```sh
cd notepadrunner
mvn package
```

To run, use the following commands:

```sh
cd target
java -jar notepadrunner-1.0-SNAPSHOT.jar arg1 arg2 arg3
```



# License

Licensed with
[2-clause license](https://en.wikipedia.org/wiki/BSD_licenses#2-clause_license_.28.22Simplified_BSD_License.22_or_.22FreeBSD_License.22.29)
("Simplified BSD License" or "FreeBSD License").
See the
[LICENSE](LICENSE.txt) file.
