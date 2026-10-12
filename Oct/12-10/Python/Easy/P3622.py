class Solution:
    def checkDivisibility(self, n):
        # Intuition: split into digits via string, then sum/multiply them
        s = str(n)
        sum = 0
        product = 1
        for c in s:
            digit = int(c)
            sum += digit
            product *= digit
        return n % (sum + product) == 0