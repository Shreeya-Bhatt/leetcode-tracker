class Solution:
    def isValid(self, s):
        stack = []
        hash_map = {')': '(', ']': '[', '}': '{'}
        
        for char in s:
            if char in hash_map:
                if stack and stack[-1] == hash_map[char]:
                    stack.pop()  
                else:
                    return False  
            else:
                stack.append(char)
        
        return not stack
