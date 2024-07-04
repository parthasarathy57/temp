import React, { useState, useEffect, useRef } from 'react';
import './App.css';

const HighlightTextarea: React.FC = () => {
  const [text, setText] = useState<string>(
    "This demo shows how to highlight specific keywords within a textarea. Feel free to edit this text. Words containing 'w' or 'g' will be highlighted."
  );

  const textareaRef = useRef<HTMLTextAreaElement>(null);
  const highlightsRef = useRef<HTMLDivElement>(null);

  const swiftCodeChars = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '/',
    '-',
    '?',
    ':',
    '(',
    ')',
    '.',
    "'",
    '+',
  ]; // Default Swift code characters

  const applyHighlights = (text: string, swiftCodeChars: string[]): string => {
    const words = text.split(/\s+/); // Split text by whitespace to get words

    return words
      .map((word) => {
        if (word.split('').some((char) => !swiftCodeChars.includes(char))) {
          return `<mark>${word}</mark>`;
        }
        return word;
      })
      .join(' ')
      .replace(/\n$/g, '\n\n');
  };

  const handleInput = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
    setText(event.target.value);
  };

  const syncScroll = () => {
    if (textareaRef.current && highlightsRef.current) {
      highlightsRef.current.scrollTop = textareaRef.current.scrollTop;
      highlightsRef.current.scrollLeft = textareaRef.current.scrollLeft;
    }
  };

  useEffect(() => {
    if (highlightsRef.current) {
      highlightsRef.current.innerHTML = applyHighlights(text, swiftCodeChars);
    }
  }, [text, swiftCodeChars]);

  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.addEventListener('scroll', syncScroll);
    }
    return () => {
      if (textareaRef.current) {
        textareaRef.current.removeEventListener('scroll', syncScroll);
      }
    };
  }, []);

  return (
    <div className="container">
      <div ref={highlightsRef} className="highlights"></div>
      <textarea
        ref={textareaRef}
        value={text}
        onChange={handleInput}
        className="textarea"
      ></textarea>
    </div>
  );
};

export default HighlightTextarea;


*,
*::before,
*::after {
  box-sizing: border-box;
}

body {
  margin: 30px;
  background-color: #f0f0f0;
}

.container {
  position: relative;
  width: 460px;
  height: 180px;
  font: 20px/28px 'Open Sans', sans-serif;
}

.textarea,
.highlights {
  width: 100%;
  height: 100%;
  padding: 10px;
  font: 20px/28px 'Open Sans', sans-serif;
  letter-spacing: 1px;
  border: 2px solid #74637f;
  resize: none;
  overflow: auto;
}

.textarea {
  position: absolute;
  top: 0;
  left: 0;
  background: transparent;
  color: transparent;
  caret-color: #444;
  z-index: 2;
}

.highlights {
  position: absolute;
  top: 0;
  left: 0;
  white-space: pre-wrap;
  word-wrap: break-word;
  z-index: 1;
  pointer-events: none;
  color: #444;
}

mark {
  background-color: #b1d5e5;
  color: #444;
}
