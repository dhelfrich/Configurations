#LastName:
#FirstName:
#Email:
#Comments:


from __future__ import print_function
import sys


# We will use a class called my trie node
class MyTrieNode:
    # Initialize some fields 
  
    def __init__(self, isRootNode=False):
        #The initialization below is just a suggestion.
        #Change it as you will.
        # But do not change the signature of the constructor.
        self.letters = "" #The letters leading up to this point
        self.isWordEnd = False # is this node a word ending node
        self.isRoot = isRootNode
        self.count = 0 # frequency count
        self.next = {} # Dictionary mappng each character from a-z to the child node


    def addWord(self,w):
        #print("adding... %s" %w)
        if (len(w) > 0):
            if (w[0] in self.next):
                (self.next[w[0]]).addWord(w[1::])
            else:
                newNode = MyTrieNode()
                self.next[w[0]] = newNode
                newNode.letters = self.letters + w[0]
                newNode.addWord(w[1::])
        if (len(w) == 1):
            self.next[w[0]].isWordEnd = True
            self.next[w[0]].count += 1
        return

    def lookupWord(self,w):
        # Return frequency of occurrence of the word w in the trie
        # returns a number for the frequency and 0 if the word w does not occur.
        #print("looking up %s" %w)
        if (len(w) == 0):
            return self.count
        elif (w[0] in self.next):
            return self.next[w[0]].lookupWord(w[1::])
        else:
            return 0
            
        
    

    def autoComplete(self,w):
        #Returns possible list of autocompletions of the word w
        #Returns a list of pairs (s,j) denoting that
        #         word s occurs with frequency j

        #Same structure as lookupWord
        currentWord = []
        if(self.isWordEnd):
            currentWord.append((self.letters, self.count))
        if (len(w) == 0):
            return currentWord + self.getPaths()
        elif (w[0] in self.next):
            return self.next[w[0]].autoComplete(w[1::])
        else:
            return currentWord

    def getPaths(self):
        #Returns the words starting with w and associated with the current node
        #In the formate specified for autocomplete
        #print("Getting paths for %s" %self.letters)
        paths = []
        if self.next:
            for node in self.next.values():
                #print(node.letters)
                if(node.isWordEnd):
                    paths.append((node.letters, node.count))
                paths = node.getPaths() + paths
        return paths
    
    
            

if (__name__ == '__main__'):
    t= MyTrieNode(True)
    lst1=['test','testament','testing','ping','pin','pink','pine','pint','testing','pinetree']

    
    print(lst1)
    for w in lst1:
        t.addWord(w)
    for w in lst1:
        print("{} occurs {} times".format(w, t.lookupWord(w)))

    j = t.lookupWord('testy') # should return 0
    j2 = t.lookupWord('telltale') # should return 0
    j3 = t.lookupWord ('testing') # should return 2
    print(j, j2, j3)
    lst3 = t.autoComplete('pi')
    print('Completions for \"pi\" are : ')
    print(lst3)
    
    lst4 = t.autoComplete('testr')
    print('Completions for \"testr\" are : ')
    print(lst4)
 
    
    
     
