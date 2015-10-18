#!/usr/bin/ruby

#Class for opening test files
class TestFile

    def initialize(filename)
      @filename = filename
      @testfile = IO.read(@filename)
    end

    def outputFile
      puts @testfile
    end

    def processFile
      #splits the file into a set of lines
      splitTestFile = @testfile.split("\n")
      command = splitTestFile[0]

      #Getting all the commands into a list
      commandVars = command.scan(/\$[0-9]+/)

      #Verifying that there are not missing  numbers
      foundNumbers = []
      $i = 0
      while $i < commandVars.count()
        a = commandVars[$i].scan(/[0-9]+/)
        if foundNumbers.include? a then 
          return false
        else 
          foundNumbers.push(a[0].to_i)
          $i+=1
        end
      end

      #Sorting the list
      foundNumbers.sort()
   
      #checking if the paramater arguments expected count lines up with the 
      #actual terms that were discovered. Essentially trying to prevent parameter
      #names that won't exist later when looking for values. In future versions
      #the complexity of possible parameters will increase.
      if (foundNumbers[-1] != (commandVars.count())) then
        return false
      end


      #Parsing the values for the parameters (comma seperated values section)

      
      testCases = []
      for a in splitTestFile[2..-1] do 
        commandNew = command 
        splitOnCommas = a.split(',')
        i = 0
        for b in splitOnCommas do 
          pattern = "\$" + (i+1).to_s
          commandNew = commandNew.gsub(pattern, b) 
          i+=1
        end 
        testCases.push(commandNew)
      end

      #Returns all of the test commands
      return testCases
    end
end

def testFile(fname)
  a = TestFile.new(fname)
  return a.processFile()
end 

puts testFile(ARGV[0])
