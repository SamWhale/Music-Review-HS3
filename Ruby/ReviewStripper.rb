require 'PearsonLongman-Dictionary'
require 'sort_alphabetical'

class ReviewStripper
    #<---------------------Code by Sam Whale--------------------------------------------->
    include DictionaryLookup
    def getWordType(word)
        begin
            DictionaryLookup::Base.define(word).first.part_of_speech #gets type of word
        rescue #error handling
            return 'invalid' #invalid is useful for debugging, and will be converted to a noun later
        else
            return DictionaryLookup::Base.define(word).first.part_of_speech  
        end
    end

    #<---------------------Code by Alex Hughes Davies------------------------------------>

    #String splitter. E.g. takes sentence and cuts the words out into an Array.
    #Sentence is a String argument.
    def stringSplit(sentence)
        wordArray = []  #this array is to contain each of the words from the sentence
        wordArray = sentence.split(/\W+/)
        return wordArray
    end

    #<--------------------Code by Alex Shmerg Schudel--------------------------------------->
    #Words - The original words (After Stringsplit)
    #Types - A corresponding array of the types of the words in the 'Words' Array (noun, adjective etc)
    #Finds the adjectives, strips out other types to Null
    def method_WordTypes(types) #Strips out the non-adjective words, leaving only "null" and "Adjective"
        types.each_index do |i|
            types[i] = 'null' if types[i] != 'adjective'
        end
        return types #Originally was "return y"
    end

    #Puts the adjectives from Words in an array
    def method_List(words,types)
        outputList = []
        # method_WordTypes(types)
        types.each_index do |i|
            outputList << words[i] if types[i] == 'adjective'
        end
        return outputList
    end

    #orders list alphabetically
    def method_Sort(a)
        outputList = []
        outputList = a.sort_alphabetical
        return outputList
    end

    #counts frequency, returns word followed by the frequency in an array (overall array is 2d)
    def method_Frequency(a) #v2 by Sam Whale
        frequency = [[]] #2d array for the output
        wordsAlreadyPicked = [] #array of the words already counted
        counter = 0

        a.each_index do |x| #for each word
            if ([a[x]] & (wordsAlreadyPicked)).empty? #If a[x] has not already been picked
                counter = a.count(a[x])
                frequency << [a[x],counter] #pack up the word and the counter 
                wordsAlreadyPicked << a[x]
            end 
        end
        return frequency
    end

    def method_Weight(a)
        weight = [[]]
        outputList = a
        outputList.each_index do |i|
            weight_2 = outputList_[2]**(-1) #reciprocal
            weight[i] = [[outputList[i], weight_2]]
        end
        return weight
    end
end
#<------------------------------main-------------------------------------------------->

w = ['z','f','e','d','c']
t = ["Hello","Hello","Hello","How","How","Are","Are","You"]
s = "Alex"

r = ReviewStripper.new
out = r.method_Frequency(t)
puts out
