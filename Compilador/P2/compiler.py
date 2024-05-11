import ply.lex as lex
import ply.yacc as yacc


def readFile(fileName):
    with open(fileName, 'r') as file:
        text = file.read()
    return text

def divideSentences(texto):
    oldSentences = texto.split('\n')  # Separar por saltos de línea
    oldSentences = [oracion.strip() for oracion in oldSentences if oracion.strip()]  # Eliminar líneas vacías y espacios adicionales

    newSentences = []
    for sentence in oldSentences:
        words = sentence.split()  # Separar por espacios en blanco
        newSentences.append(words)

    return newSentences

def groupSentences(matrix):
    result = ""

    for row in matrix:
        result += " ".join(row) + "\n"

    return result

def addStalls(sentences):
    codeWithStalls = []
    destinationRegisters = []
    stalls = []

    destinationInstruction = ["set", "add", "sub", "lsl", "ldr",'and','or']
    operandInstruction = ["add", "sub", "lsl", "cmp", "str",'and','or']
    branchInstruction = ["bal", "beq", "bge"]

    for i in range (0, len(sentences) - 1):
        codeWithStalls.append(sentences[i])

        CurrentInstructionOpCode = sentences[i][0]
        updateDestinationRegisters(destinationRegisters)
        if(CurrentInstructionOpCode in destinationInstruction):
            destinationRegisters.append([removeComa(sentences[i][1]), 3])
        
        elif(CurrentInstructionOpCode in branchInstruction):
                codeWithStalls.append(["not"])
                codeWithStalls.append(["not"])

        stallsNeeded = 0
        NextInstructionOpCode = sentences[i + 1][0]
        if(NextInstructionOpCode in operandInstruction):
            if (NextInstructionOpCode == "cmp" or NextInstructionOpCode == "str"):
                NextInstructionOperand1 = removeComa(sentences[i + 1][1])
                NextInstructionOperand2 = NextInstructionOperand1

            else:
                NextInstructionOperand1 = removeComa(sentences[i + 1][2])
                NextInstructionOperand2 = removeComa(sentences[i + 1][3])

            for j in range (0, len(destinationRegisters)):
                if (NextInstructionOperand1 == destinationRegisters[j][0]):
                    stalls.append(destinationRegisters[j][1])
                if (NextInstructionOperand2 == destinationRegisters[j][0]):
                    stalls.append(destinationRegisters[j][1])
            if (len(stalls) > 0 ):
                stallsNeeded = max(stalls)
                for j in range(0, stallsNeeded):
                    codeWithStalls.append(["not"])
                destinationRegisters.clear()
                stalls.clear()

    codeWithStalls.append(sentences[len(sentences) - 1])
    return codeWithStalls


def updateDestinationRegisters(destinationRegisters):
    if(len(destinationRegisters) > 0):
        for i in range (0, len(destinationRegisters)):
            destinationRegisters[i][1] = destinationRegisters[i][1] - 1
        if (destinationRegisters[0][1] == 0):
            destinationRegisters.pop(0)   


def removeComa(word):
    if word.endswith(','):  
        return word[:-1]  
    else:
        return word  


# USO
fileName = "archivo.marc" 
ISASentences = divideSentences(readFile(fileName))
codeWithStalls = groupSentences(addStalls(ISASentences))
print('stall',codeWithStalls)


# Definición de tokens
tokens = (
    'ADD', 'SUB', 'AND', 'ORR', 'LSL', 'CMP', 'LDR', 'STR', 'BAL', 'BEQ', 'BGE', 'NOT', 'INTEGER', 'REG', 'coma', 'SET','PARENTR','PARENTL', 'LABEL', 'END'
)

t_ADD = r'add'
t_SUB = r'sub'
t_AND = r'and'
t_ORR = r'orr'
t_LSL = r'lsl'
t_CMP = r'cmp'
t_LDR = r'ldr'
t_STR = r'str'
t_BAL = r'bal'
t_BEQ = r'beq'
t_BGE = r'bge'
t_NOT = r'not'
t_SET = r'set'
t_INTEGER = r'\#(0[xX][0-9a-fA-F]+|\d+)'
t_REG = r'r\d+'  # Registro
t_coma=r','
t_PARENTR = r'\]'
t_PARENTL = r'\['
t_LABEL=r'[_a-zA-Z][_a-zA-Z0-9]*:'
t_END=r'end'
# Ignorar caracteres como espacios y tabulaciones
t_ignore = ' \t\n'
labels={}
# Definir una acción para manejar errores léxicos
def t_COMMENT(t):
    r'\@.*'
    pass
    # No return value. Token discarded

def t_error(t):
    print(f"Error léxico: Carácter ilegal '{t.value[0]}'")
    t.lexer.skip(1)

# Construir el analizador léxico
lexer = lex.lex()


pc=0 # pc


def p_program(p):
    
    '''program : instructions
               
    '''
    global pc
    pc=0
    p[0] = p[1]

def p_instructions(p):
   
    '''instructions : instructions instruction
                    | instruction'''
    global pc

    global pc
    """ if len(p) == 2:
        if p[1] != None:
            p[0] = [p[1]]
            pc += 2  # Incrementa solo para instrucciones, no para etiquetas
    else:
        if p[2] != None:
            p[0] = p[1] + [p[2]]
            pc += 2  # Incrementa solo para instrucciones, no para etiquetas"""
    
    if len(p) == 2:
        
        if  type(p[1])!=str:
          
            p[0] = [p[1]]
            pc+=1

        else:
            p[0] = [p[1]]            
    else:
        
        if  type(p[2])!=str:
          
            p[0] = p[1] + [p[2]]
            pc+=1
        else:
            p[0] = p[1] + [p[2]]
  

def p_instruction(p):
 
    '''instruction : arithmetic_instruction
                   | comparison_instruction
                   | memory_instruction
                   | jump_instruction
                   | stall_instruction
                   | settear_instruction
                   | label_instruction
                   | end_instruction

                   '''
    
    p[0] = p[1]

def p_arithmetic_instruction(p):
    '''arithmetic_instruction : ADD REG coma REG coma REG
                              | SUB REG coma REG coma REG
                              | AND REG coma REG coma REG
                              | ORR REG coma REG coma REG
                              | LSL REG coma REG coma REG'''
    global pc
    p[0] = (p[1], p[2], p[4], p[6],pc)

def p_comparison_instruction(p):
    '''comparison_instruction : CMP REG coma REG
                               | CMP REG coma INTEGER'''
    global pc
    p[0] = (p[1], p[2], p[4],pc)

def p_memory_instruction(p):
    '''memory_instruction : LDR REG coma PARENTL REG PARENTR
                          | STR REG coma PARENTL REG PARENTR '''
    global pc
    p[0] = (p[1], p[2], p[5], pc)
def p_settear_instruction(p):
    '''settear_instruction : SET REG coma INTEGER
                            | SET REG coma REG
    
    '''
    global pc
    p[0]= (p[1], p[2], p[4],pc)
def p_jump_instruction(p):
    '''jump_instruction : BAL LABEL
                        | BEQ LABEL
                        | BGE LABEL'''
    global pc
    p[0] = (p[1], p[2], pc) # para remover los dos puntos
    #pc+=2

def p_label_instruction(p):
    '''label_instruction : LABEL'''
    global pc
    
    labels[p[1]] = pc  # Almacena la dirección de memoria asociada a la etiqueta
    p[0] = p[1]


def p_stall_instruction(p):
    '''stall_instruction : NOT'''
    p[0] = (p[1],)
def p_end_instruction(p):
    ''' end_instruction : END'''
    p[0] = (p[1],)

# Definir una acción para manejar errores sintácticos
def p_error(p):
    if p:
        print(f"Error sintáctico en línea {p.lineno}: Token '{p.value}' no esperado")
    else:
        print("Error sintáctico: Fin inesperado del archivo")

# Construir el analizador sintáctico
parser = yacc.yacc()

# Función para analizar una cadena de entrada
def parse(input_text):
    return parser.parse(input_text)

def translate_instruction(instruction, args , pc):
    opcode = {
        'add': '0000',
        'sub': '0001',
        'and': '0010',
        'orr': '0011',
        'lsl': '0100',
        'cmp': '0101',
        'set': '0110',
        'ldr': '0111',
        'str': '1000',
        'bal': '1001',
        'beq': '1010',
        'bge': '1011',
        'not': '1100',
        'end': '1101'
    }

    if instruction in opcode:
        binary_instruction = opcode[instruction]
        if instruction=="add" or instruction=="sub" or instruction=="and" or instruction=="orr" or instruction=="lsl":
            reg1 = format(int(args[0][1:]), '04b')  # Registro 1
            reg2 = format(int(args[1][1:]), '04b')  # Registro 2
            reg3 = format(int(args[2][1:]), '04b')  # Registro 3
            binary_instruction += reg1 + reg2 + reg3

        elif instruction=="cmp" or instruction=="set":
            # rd, rm
            if args[1][0]=="r":
                reg1=format(int(args[0][1:]),'04b')# registro1
                reg2=format(int(args[1][1:]),'04b')# registro1
                reg3 = format(0, '03b')  # Registro 3
                binary_instruction += reg1 + reg2 + reg3
            # rd, #
            else:
                
                reg1=format(int(args[0][1:]),'04b')# registro1
                if args[1][1:3]=='0x':
                    value=format(int(args[1][3:],16),'07b')
                    
                else:
                    value=format(int(args[1][1:]), '07b')
                binary_instruction += reg1 + value + "1"


        elif instruction=="ldr":
            reg1 = format(int(args[0][1:]), '04b')  # Registro 1
            reg2 = format(int(args[1][1:]), '04b')  # Registro 2
            reg3 = format(0, '04b')  # Registro 3
            binary_instruction += reg1 + reg2 + reg3

        elif instruction=='str':
            reg1 = format(int(args[0][1:]), '04b')  # Registro 1
            reg2 = format(int(args[1][1:]), '04b')  # Registro 2
            reg0 = format(0, '04b')  # Registro 3
            binary_instruction += reg0 + reg1 + reg2 


        elif instruction=="bal" or instruction=="bge" or instruction=="beq":
            target_label = args[0]
            jump_address = labels[target_label]
            #print(jump_address, pc)
            #relative_address=(jump_address-pc)//2
            

            binary_instruction += format(jump_address, '012b')  # Convertir la dirección a binario
            print("slato binario",binary_instruction)
            #binary_instruction += format(int(args[1]), '012b')  # Dirección de salto (12 bits)
            #print("relative address", jump_address, "binario",format(jump_address, '012b')  )

        elif instruction=='not' or instruction=='end':
            binary_instruction+=format(0,'012b') 
        return binary_instruction
    else:
        return None  # Manejar instrucciones no reconocidas

# Ejemplo de uso

#lexer.input(input_text)
#for i in lexer:
#   print(i)

#input_text=file.read()


result = parse(codeWithStalls)
print(result)
binary_string=''
a=0
print(labels)
for item in result:
   
    if isinstance(item, tuple):
        print(item)
        instruction = item[0]
    
        args = item[1:]
     
        binary_representation = translate_instruction(instruction, args,pc)
        binary_string+=binary_representation
        print(binary_representation)  # Aquí obtendrás la representación binaria de cada instrucción
        
print(binary_string)



def createInstructionsMif(binary_string, filename):
    # Open the MIF file for writing
    with open(filename, 'w') as f:
        # Write the MIF file header
        f.write("WIDTH=16;\n")
        f.write("DEPTH=4096;\n")
        f.write("\n")
        f.write("ADDRESS_RADIX=UNS;\n")
        f.write("DATA_RADIX=UNS;\n")
        f.write("\n")
        f.write("CONTENT BEGIN\n")
        
        # Iterate over the binary string in chunks of 16 characters
        for i in range(0, len(binary_string), 16):
            # Convert binary string to decimal
            decimal_value = int(binary_string[i:i+16], 2)
            # Write the address and corresponding decimal value
            f.write(f"    {i//16}   :   {decimal_value};\n")
        
        # Write the default values for remaining addresses
        f.write("    [{}..4095]   : 0;\n".format((len(binary_string) // 16)))
        
        # Write the MIF file footer
        f.write("END;\n")

def createDataMif(text_string, filename):
    # Open the MIF file for writing
    with open(filename, 'w') as f:
        # Write the MIF file header
        f.write("WIDTH=16;\n")
        f.write("DEPTH=640;\n")
        f.write("\n")
        f.write("ADDRESS_RADIX=UNS;\n")
        f.write("DATA_RADIX=UNS;\n")
        f.write("\n")
        f.write("CONTENT BEGIN\n")
        
        # Iterate over the text string in chunks of 2 characters
        for i in range(0, len(text_string), 2):
            # Convert characters to ASCII values
            if i+1 < len(text_string):
                ascii_value = ord(text_string[i+1]) * 256 + ord(text_string[i])
            else:
                ascii_value = ord(text_string[i]) * 256
            # Write the address and corresponding ASCII value
            f.write(f"    {i//2}   :   {ascii_value};\n")
        
        # Write the default values for remaining addresses
        f.write("    [{}..639]   : 0;\n".format((len(text_string) // 2)))
        
        # Write the MIF file footer
        f.write("END;\n")

# Example usage
text_string = "HELLO WORLD"  # Sample text string
createDataMif(text_string, "data.mif")  # Create MIF file

# Example usage
 
createInstructionsMif(binary_string, "instructions.mif")  # Create MIF file



