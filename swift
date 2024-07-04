import React, { useState, useEffect, useRef } from 'react';
import './App.css';

const HighlightTextarea: React.FC = () => {
  const [text, setText] = useState<string>(
    "This demo shows how to highlight specific keywords within a textarea. Feel free to edit this text."
  );

  const textareaRef = useRef<HTMLTextAreaElement>(null);
  const highlightsRef = useRef<HTMLDivElement>(null);

  const applyHighlights = (text: string, highlightChars: string[]): string => {
    const regex = new RegExp(`([a-zA-Z0-9/\\-\\?:().,'+])`, 'gi');
    const words = text.split(' ');
    return words
      .map(word => {
        if (highlightChars.some(char => regex.test(word))) {
          return `<mark>${word}</mark>`;
        }
        return `<span class="non-highlight">${word}</span>`;
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
    const highlightChars = ['w', 'g', '-', '/', ':', '(', ')', '.', ',', '\'', '+', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    if (highlightsRef.current) {
      highlightsRef.current.innerHTML = applyHighlights(text, highlightChars);
    }
  }, [text]);

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



@import url(https://fonts.googleapis.com/css?family=Open+Sans);

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

.non-highlight {
  color: blue;
}