//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MasterpageTest.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class MCQResponse
    {
        public int MCQQuestionID { get; set; }
        public string Email { get; set; }
        public string AnswerResponse { get; set; }
    
        public virtual MCQQuestion MCQQuestion { get; set; }
        public virtual Person Person { get; set; }
    }
}
